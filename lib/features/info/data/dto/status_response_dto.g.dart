// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusResponseDTO _$StatusResponseDTOFromJson(Map<String, dynamic> json) =>
    StatusResponseDTO(
      serverVersion: json['serverVersion'] as String?,
      serverOnline: json['serverOnline'] as bool,
      dataBaseOnline: json['dataBaseOnline'] as bool?,
    );

Map<String, dynamic> _$StatusResponseDTOToJson(StatusResponseDTO instance) =>
    <String, dynamic>{
      'serverVersion': instance.serverVersion,
      'serverOnline': instance.serverOnline,
      'dataBaseOnline': instance.dataBaseOnline,
    };
