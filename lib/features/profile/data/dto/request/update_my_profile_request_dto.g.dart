// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_my_profile_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMyProfileRequestDTO _$UpdateMyProfileRequestDTOFromJson(
  Map<String, dynamic> json,
) => UpdateMyProfileRequestDTO(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  aboutMe: json['aboutMe'] as String,
  removeProfileImage: json['removeProfileImage'] as bool,
);

Map<String, dynamic> _$UpdateMyProfileRequestDTOToJson(
  UpdateMyProfileRequestDTO instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'aboutMe': instance.aboutMe,
  'removeProfileImage': instance.removeProfileImage,
};
