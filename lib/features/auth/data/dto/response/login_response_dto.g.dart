// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDTO _$LoginResponseDTOFromJson(Map<String, dynamic> json) =>
    LoginResponseDTO(
      userId: (json['userId'] as num).toInt(),
      username: json['username'] as String,
      myProfileUrl: json['myProfileUrl'] as String?,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$LoginResponseDTOToJson(LoginResponseDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'myProfileUrl': instance.myProfileUrl,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
