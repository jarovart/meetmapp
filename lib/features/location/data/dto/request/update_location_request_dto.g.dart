// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_location_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLocationRequestDTO _$UpdateLocationRequestDTOFromJson(
  Map<String, dynamic> json,
) => UpdateLocationRequestDTO(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  startDateTime: DateTime.parse(json['startDateTime'] as String),
  endDateTime: DateTime.parse(json['endDateTime'] as String),
  imageRequests: (json['imageRequests'] as List<dynamic>)
      .map((e) => ImageEntryRequestDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UpdateLocationRequestDTOToJson(
  UpdateLocationRequestDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'address': instance.address,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'startDateTime': instance.startDateTime.toIso8601String(),
  'endDateTime': instance.endDateTime.toIso8601String(),
  'imageRequests': instance.imageRequests,
};
