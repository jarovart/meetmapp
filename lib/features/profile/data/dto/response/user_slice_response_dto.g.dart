// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_slice_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSliceResponseDTO _$UserSliceResponseDTOFromJson(
  Map<String, dynamic> json,
) => UserSliceResponseDTO(
  content: (json['content'] as List<dynamic>)
      .map((e) => ProfileResponseDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  last: json['last'] as bool,
);

Map<String, dynamic> _$UserSliceResponseDTOToJson(
  UserSliceResponseDTO instance,
) => <String, dynamic>{'content': instance.content, 'last': instance.last};
