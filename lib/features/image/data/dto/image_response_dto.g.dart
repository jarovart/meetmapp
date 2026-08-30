// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponseDTO _$ImageResponseDTOFromJson(Map<String, dynamic> json) =>
    ImageResponseDTO(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$ImageResponseDTOToJson(ImageResponseDTO instance) =>
    <String, dynamic>{'id': instance.id, 'imageUrl': instance.imageUrl};
