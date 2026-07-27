import 'package:casttime/features/location/data/dto/response/image_response_dto.dart';
import 'package:casttime/features/location/domain/model/image.dart';

extension ImageDtoMapper on ImageResponseDTO {
  Image toDomain() {
    return Image(id: id, imageUrl: imageUrl);
  }
}
