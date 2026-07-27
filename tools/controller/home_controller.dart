import 'package:flutter/material.dart';
import 'package:casttime/app/model/response/usermyprofile_response.dart';

class HomeController extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  static const double _menuWidth = 260;
  UserMyProfileResponse? _myProfile;
  bool _isMenuOpen = false;
  int _index = 0;
  bool _refreshIndex = false;

  static double get menuWidth => _menuWidth;
  bool get loggedIn => _myProfile != null;
  bool get isMenuOpen => _isMenuOpen;

  UserMyProfileResponse? get myProfile => _myProfile;

  int get index => _index;

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

  void changeValue(int value) {
    _refreshIndex = _index == value;

    _index = value;
    debugPrint("$value");
    notifyListeners();
  }
}
