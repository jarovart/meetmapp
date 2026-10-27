// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordRequestDTO _$ForgotPasswordRequestDTOFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordRequestDTO(
  email: json['email'] as String,
  languageCode: json['languageCode'] as String,
);

Map<String, dynamic> _$ForgotPasswordRequestDTOToJson(
  ForgotPasswordRequestDTO instance,
) => <String, dynamic>{
  'email': instance.email,
  'languageCode': instance.languageCode,
};
