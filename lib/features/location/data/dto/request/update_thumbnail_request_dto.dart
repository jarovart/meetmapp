import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_thumbnail_request_dto.g.dart';

@JsonSerializable()
class UpdateThumbnailRequestDTO {
  final int imageId;

  UpdateThumbnailRequestDTO({required this.imageId});

  factory UpdateThumbnailRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateThumbnailRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateThumbnailRequestDTOToJson(this);
}
