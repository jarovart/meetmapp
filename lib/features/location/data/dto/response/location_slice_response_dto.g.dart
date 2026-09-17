// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_slice_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationSliceResponseDTO _$LocationSliceResponseDTOFromJson(
  Map<String, dynamic> json,
) => LocationSliceResponseDTO(
  content: (json['content'] as List<dynamic>)
      .map((e) => LocationBaseResponseDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  last: json['last'] as bool,
);

Map<String, dynamic> _$LocationSliceResponseDTOToJson(
  LocationSliceResponseDTO instance,
) => <String, dynamic>{'content': instance.content, 'last': instance.last};
