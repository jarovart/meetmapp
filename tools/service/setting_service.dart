import 'package:flutter/material.dart';
import 'package:casttime/app/model/request/settings_request.dart';
import 'package:casttime/app/model/response/settings_response.dart';
import 'package:casttime/app/repository/setting_repository.dart';
import 'package:casttime/app/service/authentication_service.dart';
import 'package:casttime/app/service/user_service.dart';

class SettingService {
  static Future<SettingsResponse?> loadLocalSettings() async {
    return await SettingRepository.getLocalSettings();
  }

  static Future<SettingsResponse?> loadSettings() async {
    SettingsResponse? settingResponse;
    try {
      if (await AuthService.isLoggedIn()) {
        final myProfile = await UserService.fetchMyProfile();
        settingResponse = await SettingRepository.loadSettings(myProfile.id);
      }
    } catch (e) {
      debugPrint("Error loading settings from backend: $e");
      settingResponse = null;
    }
    final savedSettings = await SettingRepository.getLocalSettings();
    debugPrint("local setting: $savedSettings");
    debugPrint("backend setting: $settingResponse");
    final newe = chooseNewest(savedSettings, settingResponse);

    debugPrint("win setting: $newe");
    return newe;
  }

  static Future<void> saveLocalSettings(SettingsRequest settings) async {
    await SettingRepository.saveLocalSettings(settings);
  }

  static Future<SettingsResponse> saveSettings(SettingsRequest settings) async {
    final settingsResponse = await SettingRepository.saveLocalSettings(
      settings,
    );

    if (await AuthService.isLoggedIn()) {
      return await SettingRepository.saveSettings(settings);
    } else {
      return settingsResponse;
    }
  }

  static SettingsResponse? chooseNewest(
    SettingsResponse? localSettings,
    SettingsResponse? backendSettings,
  ) {
    if (localSettings == null && backendSettings == null) {
      return null;
    }

    if (backendSettings == null) {
      return localSettings;
    }

    if (localSettings == null) {
      return backendSettings;
    }

    return localSettings.updatedAt.isAfter(backendSettings.updatedAt)
        ? localSettings
        : backendSettings;
  }
}
