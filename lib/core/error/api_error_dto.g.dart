// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorDTO _$ApiErrorDTOFromJson(Map<String, dynamic> json) => ApiErrorDTO(
  code: json['code'] as String,
  message: json['message'] as String,
  requestId: json['requestId'] as String?,
  fieldErrors:
      (json['fieldErrors'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  cooldownSeconds: (json['cooldownSeconds'] as num?)?.toInt(),
);

Map<String, dynamic> _$ApiErrorDTOToJson(ApiErrorDTO instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'requestId': instance.requestId,
      'fieldErrors': instance.fieldErrors,
      'cooldownSeconds': instance.cooldownSeconds,
    };
