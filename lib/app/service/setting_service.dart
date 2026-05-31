import 'package:meetmaap/app/model/response/settings_response.dart';
import 'package:meetmaap/app/repository/setting_repository.dart';
import 'package:meetmaap/app/service/authentication_service.dart';
import 'package:meetmaap/app/service/user_service.dart';

class SettingService {
  static Future<SettingResponse?> loadLocalSettings() async {
    return await SettingRepository.getLocalSettings();
  }

  static Future<SettingResponse?> loadSettings() async {
    SettingResponse? settingResponse;
    try {
      if (await AuthService.isLoggedIn()) {
        final myProfile = await UserService.fetchMyProfile();
        settingResponse = await SettingRepository.loadSettings(myProfile.id);
      }
    } catch (e) {
      settingResponse = null;
    }
    final savedSettings = await SettingRepository.getLocalSettings();
    return chooseNewest(savedSettings, settingResponse);
  }

  static Future<void> saveSettings(SettingResponse settings) async {
    await SettingRepository.saveSettings(settings);
  }

  static SettingResponse? chooseNewest(
    SettingResponse? localSettings,
    SettingResponse? backendSettings,
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
