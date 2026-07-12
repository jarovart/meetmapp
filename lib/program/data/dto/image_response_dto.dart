import 'package:json_annotation/json_annotation.dart';

part 'image_response_dto.g.dart';

@JsonSerializable()
class ImageResponseDTO {
  final int id;
  final String imageUrl;

  ImageResponseDTO({required this.id, required this.imageUrl});

  factory ImageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseDTOToJson(this);
}
