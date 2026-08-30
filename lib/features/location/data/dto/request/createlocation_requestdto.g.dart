// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createlocation_requestdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLocationRequestDTO _$CreateLocationRequestDTOFromJson(
  Map<String, dynamic> json,
) => CreateLocationRequestDTO(
  title: json['title'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$CreateLocationRequestDTOToJson(
  CreateLocationRequestDTO instance,
) => <String, dynamic>{
  'title': instance.title,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
