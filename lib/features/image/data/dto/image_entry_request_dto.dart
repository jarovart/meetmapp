import 'package:json_annotation/json_annotation.dart';

part 'image_entry_request_dto.g.dart';

@JsonSerializable()
class ImageEntryRequestDTO {
  const ImageEntryRequestDTO({
    this.id,
    required this.isNew,
    required this.sortIndex,
  });

  final int? id;
  final bool isNew;
  final int sortIndex;

  factory ImageEntryRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageEntryRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageEntryRequestDTOToJson(this);
}
