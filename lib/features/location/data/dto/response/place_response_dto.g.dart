// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceResponseDTO _$PlaceResponseDTOFromJson(Map<String, dynamic> json) =>
    PlaceResponseDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      existedPlace: json['existedPlace'] as bool,
    );

Map<String, dynamic> _$PlaceResponseDTOToJson(PlaceResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'existedPlace': instance.existedPlace,
    };
