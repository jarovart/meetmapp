import 'dart:ui';

import 'package:flutter/foundation.dart';

class SettingsController extends ChangeNotifier {
  SettingsController();
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  Locale? _locale;
  bool _isDarkMode = false;
  String _language = 'Deutsch';

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  Locale? get locale => _locale;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setLanguage(String? languageCode) {
    if (languageCode == null) {
      _locale = null; // Systemsprache
    } else {
      _locale = Locale(languageCode);
    }

    notifyListeners();
  }
}
