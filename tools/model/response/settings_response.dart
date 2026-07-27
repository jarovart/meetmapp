import 'dart:ui';

import 'package:casttime/app/model/enums/appdesign.dart';

class SettingsResponse {
  final int? id;
  final Locale? locale;
  final AppDesign design;
  final DateTime updatedAt;

  SettingsResponse({
    required this.id,
    required this.locale,
    required this.design,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "locale": locale?.languageCode.toLowerCase() ?? "sys",
      "design": design.name,
      "updatedAt": updatedAt.toIso8601String(),
    };
  }

  factory SettingsResponse.fromMap(Map<String, dynamic> map) {
    return SettingsResponse(
      id: map['id'] as int?,
      locale: map['locale'] == "SYS"
          ? null
          : Locale(map['locale'].toString().toLowerCase()),
      design: AppDesign.values.firstWhere(
        (e) => e.name.toUpperCase() == map['design'],
        orElse: () => AppDesign.system,
      ),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  @override
  String toString() {
    return "SettingsResponse(id: $id, locale: ${locale?.languageCode}, design: ${design.name}, updatedAt: $updatedAt)";
  }
}
