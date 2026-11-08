// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_location_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLocationRequestDTO _$CreateLocationRequestDTOFromJson(
  Map<String, dynamic> json,
) => CreateLocationRequestDTO(
  title: json['title'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  creationDateTime: DateTime.parse(json['creationDateTime'] as String),
  startDateTime: DateTime.parse(json['startDateTime'] as String),
  endDateTime: DateTime.parse(json['endDateTime'] as String),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  createdUsername: json['createdUsername'] as String,
);

Map<String, dynamic> _$CreateLocationRequestDTOToJson(
  CreateLocationRequestDTO instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'address': instance.address,
  'creationDateTime': instance.creationDateTime.toIso8601String(),
  'startDateTime': instance.startDateTime.toIso8601String(),
  'endDateTime': instance.endDateTime.toIso8601String(),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'createdUsername': instance.createdUsername,
};
