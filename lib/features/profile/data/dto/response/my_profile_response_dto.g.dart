// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileResponseDTO _$MyProfileResponseDTOFromJson(
  Map<String, dynamic> json,
) => MyProfileResponseDTO(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  profileImage: json['profileImage'] == null
      ? null
      : ImageResponseDTO.fromJson(json['profileImage'] as Map<String, dynamic>),
  aboutMe: json['aboutMe'] as String?,
  likedLocationCount: (json['likedLocationCount'] as num).toInt(),
  joinedLocationCount: (json['joinedLocationCount'] as num).toInt(),
  email: json['email'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  createdLocationCount: (json['createdLocationCount'] as num).toInt(),
);

Map<String, dynamic> _$MyProfileResponseDTOToJson(
  MyProfileResponseDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profileImage': instance.profileImage,
  'aboutMe': instance.aboutMe,
  'likedLocationCount': instance.likedLocationCount,
  'joinedLocationCount': instance.joinedLocationCount,
  'email': instance.email,
  'createdAt': instance.createdAt.toIso8601String(),
  'createdLocationCount': instance.createdLocationCount,
};
