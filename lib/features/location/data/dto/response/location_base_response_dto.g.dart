// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_base_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationBaseResponseDTO _$LocationBaseResponseDTOFromJson(
  Map<String, dynamic> json,
) => LocationBaseResponseDTO(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  creationDateTime: DateTime.parse(json['creationDateTime'] as String),
  startDateTime: DateTime.parse(json['startDateTime'] as String),
  endDateTime: DateTime.parse(json['endDateTime'] as String),
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  thumbnailImage: json['thumbnailImage'] == null
      ? null
      : ImageResponseDTO.fromJson(
          json['thumbnailImage'] as Map<String, dynamic>,
        ),
  createdUserId: (json['createdUserId'] as num).toInt(),
  createdUsername: json['createdUsername'] as String,
  likedUserCount: (json['likedUserCount'] as num).toInt(),
  joinedUserCount: (json['joinedUserCount'] as num).toInt(),
  likedByCurrentUser: json['likedByCurrentUser'] as bool?,
  joinedByCurrentUser: json['joinedByCurrentUser'] as bool?,
);

Map<String, dynamic> _$LocationBaseResponseDTOToJson(
  LocationBaseResponseDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'address': instance.address,
  'creationDateTime': instance.creationDateTime.toIso8601String(),
  'startDateTime': instance.startDateTime.toIso8601String(),
  'endDateTime': instance.endDateTime.toIso8601String(),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'thumbnailImage': instance.thumbnailImage,
  'createdUserId': instance.createdUserId,
  'createdUsername': instance.createdUsername,
  'likedUserCount': instance.likedUserCount,
  'joinedUserCount': instance.joinedUserCount,
  'likedByCurrentUser': instance.likedByCurrentUser,
  'joinedByCurrentUser': instance.joinedByCurrentUser,
};
