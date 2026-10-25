import 'dart:ui';

import 'package:casttime/app/theme/appdesign.dart';
import 'package:casttime/features/setting/data/dto/response/settings_response_dto.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';

extension SettingsResponseDtoMapper on SettingsResponseDTO {
  AppSettings toDomain() {
    return AppSettings(
      locale:
          languageCode == null ||
              languageCode!.isEmpty ||
              languageCode!.toLowerCase() == 'sys'
          ? null
          : Locale(languageCode!),
      design: AppDesign.values.firstWhere(
        (d) => d.name.toLowerCase() == design.toLowerCase(),
        orElse: () => AppDesign.system,
      ),
      updatedAt: updatedAt,
    );
  }
}
