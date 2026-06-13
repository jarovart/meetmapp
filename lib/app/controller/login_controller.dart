import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';

class LoginController extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  Object? _error;
  UserMyProfileResponse? _myProfile;

  bool get loading => _loading;
  bool get loggedIn => _myProfile != null;
  bool get hasErrors => _error != null;
  Object? get error => _error;
  TextEditingController get userCtrl => _userCtrl;
  TextEditingController get passCtrl => _passCtrl;

  String get myUserName => _myProfile?.username ?? '';
  UserMyProfileResponse? get myProfile => _myProfile;

  void updateMyProfile(UserMyProfileResponse? myProfile) {
    _myProfile = myProfile;
    notifyListeners();
  }

  void resetState() {
    _loading = true;
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> submit(
    AuthController authController,
    SettingsController settingsController,
  ) async {
    resetState();

    try {
      await authController.login(_userCtrl.text.trim(), _passCtrl.text);
      await authController.refreshLogin("submitbutton");
      final myUserName = authController.myUserName;
      debugPrint('Logged in as $myUserName');

      TextInput.finishAutofillContext();
    } catch (e, st) {
      debugPrint('Error while log in profile: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
    await settingsController.loadSettings(forceUpdate: true);
  }

  Future<void> submitLogout(AuthController authController) async {
    resetState();

    try {
      await authController.logout();
    } catch (e, st) {
      debugPrint('Error while log out profile: $e');
      debugPrintStack(stackTrace: st);

      _error = error;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
