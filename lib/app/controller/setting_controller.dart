import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:meetmaap/app/model/enums/appdesign.dart';
import 'package:meetmaap/app/model/response/settings_response.dart';
import 'package:meetmaap/app/service/setting_service.dart';
import 'package:meetmaap/app/view/model/appliedsettings_model.dart';
import 'package:meetmaap/app/view/model/draftsettings_model.dart';

class SettingsController extends ChangeNotifier {
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────

  DraftAppSettings? _draftSetting;
  AppliedAppSettings? _appliedSetting;
  SettingResponse? _settingResponse;
  Object? _error;

  AppliedAppSettings get appliedSetting => _appliedSetting!;
  Locale? get locale => _draftSetting?.locale;
  AppDesign get design => _appliedSetting?.design ?? AppDesign.system;
  bool get hasError => _error != null;
  Object? get error => _error;

  Locale? _locale;
  bool _isDarkMode = false;
  String _language = 'Deutsch';

  bool get isDarkMode => _isDarkMode;
  String get language => _language;

  void _init() {
    _draftSetting = DraftAppSettings(locale: null, design: AppDesign.system);
    _appliedSetting = AppliedAppSettings(
      locale: null,
      design: AppDesign.system,
    );
    notifyListeners(); // nur SettingsPage sollte darauf hören
  }

  // ─────────────────────────────────────────────
  // LOAD
  // ─────────────────────────────────────────────
  Future<void> loadSettingsLocal() async {
    try {
      final loadedSettings = await SettingService.loadLocalSettings();

      _draftSetting = DraftAppSettings(
        locale: loadedSettings?.locale,
        design: loadedSettings?.design ?? AppDesign.system,
      );

      _appliedSetting = AppliedAppSettings(
        locale: loadedSettings?.locale,
        design: loadedSettings?.design ?? AppDesign.system,
      );
    } catch (e) {
      debugPrint("error loading settings before app start: $e");
      _init();
    }
  }

  Future<void> loadSettings() async {
    _init();
    try {
      _settingResponse = await SettingService.loadSettings();
      if (_settingResponse != null) {
        _draftSetting = _draftSetting!.copyWith(
          locale: _settingResponse!.locale,
          design: _settingResponse!.design,
        );
      }
    } catch (e, st) {
      debugPrint('Error loading settings: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  void changeDraftLanguage(String? languageCode) {
    _draftSetting = _draftSetting!.copyWith(
      locale: languageCode != null ? Locale(languageCode!) : null,
    );
    notifyListeners();
  }

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

  Future<void> saveSettings() async {
    _appliedSetting = AppliedAppSettings(
      locale: _draftSetting?.locale,
      design: _draftSetting?.design ?? AppDesign.system,
    );
    notifyListeners();
  }
}
