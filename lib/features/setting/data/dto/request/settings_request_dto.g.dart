// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsRequestDTO _$SettingsRequestDTOFromJson(Map<String, dynamic> json) =>
    SettingsRequestDTO(
      languageCode: json['languageCode'] as String?,
      design: json['design'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SettingsRequestDTOToJson(SettingsRequestDTO instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'design': instance.design,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
