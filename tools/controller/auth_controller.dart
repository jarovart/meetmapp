import 'package:flutter/material.dart';
import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/model/response/usermyprofile_response.dart';
import 'package:casttime/app/service/authentication_service.dart';

class AuthController extends ChangeNotifier with WidgetsBindingObserver {
  UserMyProfileResponse? _myProfile;
  DateTime? _lastRefreshAt;
  String? _token;

  AuthController(String source) {
    WidgetsBinding.instance.addObserver(this);
    loadSession("(Constructor  $source)");
  }

  bool get isLoggedIn => myProfile != null;
  String get myUserName => _myProfile?.username ?? '';
  UserMyProfileResponse? get myProfile => _myProfile;

  bool get hasToken => _token != null && _token!.isNotEmpty;

  Future<void> login(String username, String password) async {
    await AuthService.login(username: username, password: password);
    _myProfile = await AuthService.getMyUserProfile();
    _token = await AuthService.getToken();
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.logout();
    _myProfile = null;
    _token = null;
    notifyListeners();
  }

  bool _isRefreshCooldownActive() {
    final now = DateTime.now();

    if (_lastRefreshAt != null &&
        now.difference(_lastRefreshAt!) <
            const Duration(seconds: AppConfig.checkLoginIntervalInSeconds)) {
      return true;
    }
    _lastRefreshAt = now;
    return false;
  }

  Future<void> loadLoginLocal() async {
    try {
      if (await AuthService.isLoggedIn()) {
        _myProfile = await AuthService.getMyUserProfile();
        _token = await AuthService.getToken();
        _lastRefreshAt = DateTime.now();
      }
    } catch (e) {
      debugPrint("Error loading login local: $e");
    }
  }

  void loadSession(String source) async {
    debugPrint("Authcontroller $source loadsession.");
    await refreshLogin(source);
  }

  Future<void> refreshLogin(String source, {bool forceUpdate = false}) async {
    debugPrint("Authcontroller $source refreshLogin before check.");
    if (!forceUpdate && _isRefreshCooldownActive()) return;
    final localMyProfile = _myProfile;

    debugPrint(
      "Authcontroller $source refreshLogin after check.==============================",
    );
    try {
      debugPrint(
        "authcontroller $source refreshLogin: cooldown inactive, not skipping",
      );
      final isLoggedIn = await AuthService.isLoggedInOnServer(
        serverReachableOptional: true,
      );

      if (isLoggedIn) {
        if (_myProfile == null) {
          debugPrint(
            "User is logged in on server but not in app, refreshing profile.",
          );
        }
        _myProfile = await AuthService.getMyUserProfile();
        _myProfile ??= await AuthService.fetchMyProfile();
        _token = await AuthService.getToken();
      } else {
        if (_myProfile != null) {
          debugPrint("User ist not logged in anymore, logging out.");
          await AuthService.logout();
          _myProfile = null;
          _token = null;
          notifyListeners();
        }
      }
    } catch (e, st) {
      debugPrint('Error in refreshLogin: $e');
      debugPrintStack(stackTrace: st);
      await AuthService.logout();
      _myProfile = null;
      _token = null;
    } finally {
      if (localMyProfile != _myProfile) notifyListeners();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await refreshLogin("(didChangeAppLifecycleState ${state.toString()})");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
