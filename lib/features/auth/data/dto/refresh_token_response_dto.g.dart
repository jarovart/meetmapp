// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponseDTO _$RefreshTokenResponseDTOFromJson(
  Map<String, dynamic> json,
) => RefreshTokenResponseDTO(
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
);

Map<String, dynamic> _$RefreshTokenResponseDTOToJson(
  RefreshTokenResponseDTO instance,
) => <String, dynamic>{
  'token': instance.token,
  'refreshToken': instance.refreshToken,
};
