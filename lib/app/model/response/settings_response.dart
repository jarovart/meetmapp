import 'dart:ui';

import 'package:meetmaap/app/model/enums/appdesign.dart';

class SettingResponse {
  final Locale? locale;
  final AppDesign design;
  final DateTime updatedAt;

  SettingResponse({
    required this.locale,
    required this.design,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "locale": locale?.languageCode ?? "null",
      "design": design.name,
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory SettingResponse.fromMap(Map<String, dynamic> map) {
    return SettingResponse(
      locale: map['locale'] == null ? null : Locale(map['locale']),
      design: AppDesign.values.firstWhere(
        (e) => e.name == map['design'],
        orElse: () => AppDesign.system,
      ),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
