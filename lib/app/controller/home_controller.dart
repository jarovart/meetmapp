import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';

class HomeController extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  static const double _menuWidth = 260;
  UserMyProfileResponse? _myProfile;
  bool _isMenuOpen = false;

  static double get menuWidth => _menuWidth;
  bool get loggedIn => _myProfile != null;
  bool get isMenuOpen => _isMenuOpen;

  UserMyProfileResponse? get myProfile => _myProfile;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  void updateMyProfile(UserMyProfileResponse? myProfile) {
    _myProfile = myProfile;
    notifyListeners();
  }
}
