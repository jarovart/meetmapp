// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createlocation_requestdto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLocationRequestDto _$CreateLocationRequestDtoFromJson(
  Map<String, dynamic> json,
) => CreateLocationRequestDto(
  title: json['title'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$CreateLocationRequestDtoToJson(
  CreateLocationRequestDto instance,
) => <String, dynamic>{
  'title': instance.title,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
