import 'package:casttime/features/setting/data/dto/request/settings_request_dto.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';

extension AppSettingsToRequestMapper on AppSettings {
  SettingsRequestDTO toRequestDTO() {
    return SettingsRequestDTO(
      languageCode: locale?.languageCode ?? 'sys',
      design: design.name,
      updatedAt: updatedAt,
    );
  }
}
