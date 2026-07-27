import 'dart:ui';

import 'package:casttime/app/model/enums/appdesign.dart';
import 'package:casttime/app/model/enums/language.dart';

class SettingsRequest {
  final Locale? locale;
  final AppDesign design;
  final DateTime updatedAt;

  SettingsRequest({
    required this.locale,
    required this.design,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "locale":
          locale?.languageCode.toUpperCase() ??
          LanguageEnum.sys.name.toUpperCase(),
      "design": design.name.toUpperCase(),
      "updatedAt": updatedAt.toIso8601String(),
    };
  }
}
