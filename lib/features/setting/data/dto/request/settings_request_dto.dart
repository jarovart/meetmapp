import 'package:json_annotation/json_annotation.dart';

part 'settings_request_dto.g.dart';

@JsonSerializable()
class SettingsRequestDTO {
  final String? languageCode;
  final String design;
  final DateTime updatedAt;

  SettingsRequestDTO({
    required this.languageCode,
    required this.design,
    required this.updatedAt,
  });

  factory SettingsRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$SettingsRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsRequestDTOToJson(this);
}
