// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_entry_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageEntryRequestDTO _$ImageEntryRequestDTOFromJson(
  Map<String, dynamic> json,
) => ImageEntryRequestDTO(
  id: (json['id'] as num?)?.toInt(),
  isNew: json['isNew'] as bool,
  sortIndex: (json['sortIndex'] as num).toInt(),
);

Map<String, dynamic> _$ImageEntryRequestDTOToJson(
  ImageEntryRequestDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'isNew': instance.isNew,
  'sortIndex': instance.sortIndex,
};
