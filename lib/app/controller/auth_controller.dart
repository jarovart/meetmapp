import 'package:flutter/material.dart';
import 'package:meetmaap/app/config/app_config.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/service/authentication_service.dart';

class AuthController extends ChangeNotifier with WidgetsBindingObserver {
  UserMyProfileResponse? _myProfile;
  DateTime? _lastRefreshAt;

  AuthController() {
    WidgetsBinding.instance.addObserver(this);
    loadSession();
  }

  bool get isLoggedIn => myProfile != null;
  String get myUserName => _myProfile?.username ?? '';
  UserMyProfileResponse? get myProfile => _myProfile;

  Future<void> loadSession() async {
    final loggedIn = await AuthService.isLoggedIn();

    if (!loggedIn) {
      _myProfile = null;
      notifyListeners();
    }

    _myProfile = await AuthService.getMyUserProfile();
    notifyListeners();
  }

  Future<void> refreshMyProfile() async {
    debugPrint("refreshing my profile");
    final loggedIn = await AuthService.isLoggedIn();
    if (!loggedIn) {
      _myProfile = null;
      notifyListeners();
      return;
    }

    _myProfile = await AuthService.getMyUserProfile();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    await AuthService.login(username: username, password: password);
    _myProfile = await AuthService.getMyUserProfile();
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.logout();
    _myProfile = null;
    notifyListeners();
  }

  void setMyProfile(UserMyProfileResponse profile) {
    _myProfile = profile;
    notifyListeners();
  }

  Future<void> refreshIfStale() async {
    final now = DateTime.now();

    if (_lastRefreshAt != null &&
        now.difference(_lastRefreshAt!) <
            const Duration(seconds: AppConfig.checkLoginIntervalInSeconds)) {
      return;
    }

    await refreshMyProfile();
    _lastRefreshAt = now;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      refreshIfStale();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
