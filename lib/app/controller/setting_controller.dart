import 'package:flutter/foundation.dart';

class SettingsController extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isDarkMode = false;
  String _language = 'Deutsch';

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
