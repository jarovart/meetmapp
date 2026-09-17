import 'package:casttime/features/image/data/dto/image_response_dto.dart';
import 'package:casttime/features/image/data/mapper/util/image_utils.dart';
import 'package:casttime/features/location/domain/model/app_image.dart';

extension ImageDtoMapper on ImageResponseDTO {
  AppImage toDomain() {
    return AppImage(id: id, imageUrl: ImageUtils.toAbsolute(imageUrl));
  }
}
