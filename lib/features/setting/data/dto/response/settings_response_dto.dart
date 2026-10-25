import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_response_dto.g.dart';

@JsonSerializable()
class SettingsResponseDTO {
  final int? id;
  final String? languageCode;
  final String design;
  final DateTime updatedAt;

  SettingsResponseDTO({
    required this.id,
    required this.languageCode,
    required this.design,
    required this.updatedAt,
  });

  factory SettingsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$SettingsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsResponseDTOToJson(this);
}
