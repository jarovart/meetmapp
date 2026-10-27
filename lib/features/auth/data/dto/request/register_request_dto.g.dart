// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestDTO _$RegisterRequestDTOFromJson(Map<String, dynamic> json) =>
    RegisterRequestDTO(
      username: json['username'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      languageCode: json['languageCode'] as String,
    );

Map<String, dynamic> _$RegisterRequestDTOToJson(RegisterRequestDTO instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'password': instance.password,
      'languageCode': instance.languageCode,
    };
