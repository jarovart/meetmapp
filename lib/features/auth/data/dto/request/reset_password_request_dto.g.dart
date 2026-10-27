// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequestDTO _$ResetPasswordRequestDTOFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequestDTO(
  token: json['token'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestDTOToJson(
  ResetPasswordRequestDTO instance,
) => <String, dynamic>{
  'token': instance.token,
  'newPassword': instance.newPassword,
};
