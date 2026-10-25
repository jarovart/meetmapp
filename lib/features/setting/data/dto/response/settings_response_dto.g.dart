// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsResponseDTO _$SettingsResponseDTOFromJson(Map<String, dynamic> json) =>
    SettingsResponseDTO(
      id: (json['id'] as num?)?.toInt(),
      languageCode: json['languageCode'] as String?,
      design: json['design'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SettingsResponseDTOToJson(
  SettingsResponseDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'languageCode': instance.languageCode,
  'design': instance.design,
  'updatedAt': instance.updatedAt.toIso8601String(),
};
