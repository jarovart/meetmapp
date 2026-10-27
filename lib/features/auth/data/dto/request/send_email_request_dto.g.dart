// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendEmailRequestDTO _$SendEmailRequestDTOFromJson(Map<String, dynamic> json) =>
    SendEmailRequestDTO(
      email: json['email'] as String,
      languageCode: json['languageCode'] as String,
    );

Map<String, dynamic> _$SendEmailRequestDTOToJson(
  SendEmailRequestDTO instance,
) => <String, dynamic>{
  'email': instance.email,
  'languageCode': instance.languageCode,
};
