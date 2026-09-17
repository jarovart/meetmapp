// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseDTO _$ProfileResponseDTOFromJson(Map<String, dynamic> json) =>
    ProfileResponseDTO(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profileImage: json['profileImage'] == null
          ? null
          : ImageResponseDTO.fromJson(
              json['profileImage'] as Map<String, dynamic>,
            ),
      aboutMe: json['aboutMe'] as String,
      likedLocationCount: (json['likedLocationCount'] as num).toInt(),
      joinedLocationCount: (json['joinedLocationCount'] as num).toInt(),
    );

Map<String, dynamic> _$ProfileResponseDTOToJson(ProfileResponseDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileImage': instance.profileImage,
      'aboutMe': instance.aboutMe,
      'likedLocationCount': instance.likedLocationCount,
      'joinedLocationCount': instance.joinedLocationCount,
    };
