import 'package:casttime/program/data/dto/image_response_dto.dart';
import 'package:casttime/program/domain/models/image.dart';

extension ImageDtoMapper on ImageResponseDTO {
  Image toDomain() {
    return Image(id: id, imageUrl: imageUrl);
  }
}
