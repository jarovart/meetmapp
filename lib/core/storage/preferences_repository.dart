import 'dart:convert';

import 'package:casttime/app/theme/appdesign.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class PreferencesRepository {
  const PreferencesRepository(this._prefs);

  static const String _settingsKey = 'user_settings';
  static const String _settingsLanguageCode = 'languageCode';
  static const String _settingsDesign = 'design';
  static const String _settingsUpdatedAt = 'updateAt';
  final SharedPreferences _prefs;

  Future<AppSettings?> readLocalSettings() async {
    final raw = _prefs.getString(_settingsKey);
    if (raw == null) {
      debugPrint('No settings found in local storage');
      return null;
    }

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return AppSettings(
        locale: json[_settingsLanguageCode] == null
            ? null
            : Locale((json[_settingsLanguageCode] as String).toLowerCase()),
        design: AppDesign.values.firstWhere(
          (d) => d.name == json[_settingsDesign],
          orElse: () => AppDesign.system,
        ),
        updatedAt: json[_settingsUpdatedAt] == null
            ? DateTime.utc(1970)
            : DateTime.parse(json[_settingsUpdatedAt] as String),
      );
    } catch (e) {
      debugPrint('Something went wrong in local storage ${e.toString()}');
      return null;
    }
  }

  Future<bool> saveLocalSettings(AppSettings settings) async {
    final settingsJson = jsonEncode({
      _settingsLanguageCode: settings.locale?.languageCode.toLowerCase(),
      _settingsDesign: settings.design.name,
      _settingsUpdatedAt: DateTime.utc(1970).toIso8601String(),
    });
    return await _prefs.setString(_settingsKey, settingsJson);
  }

  Future<bool> removeLocalSettings(AppSettings settings) async {
    return await _prefs.remove(_settingsKey);
  }

  AppSettings getDefaultAppSettings() {
    AppSettings settings = AppSettings(
      design: AppDesign.system,
      locale: null,
      updatedAt: DateTime.utc(1970),
    );
    return settings;
  }

  Future<AppSettings> createDefaultLocalAppSettings() async {
    AppSettings settings = AppSettings(
      design: AppDesign.system,
      locale: null,
      updatedAt: DateTime.utc(1970),
    );
    await saveLocalSettings(settings);
    return settings;
  }
}
