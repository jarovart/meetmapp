import 'dart:typed_data';

import 'package:meetmaap/app/model/requests/updatethumbnail_request.dart';
import 'package:meetmaap/app/model/responses/image_response.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/repository/image_repository.dart';

class ImageService {
  static Future<List<String>> uploadImages1(List<Uint8List> images) async {
    return await ImageRepository.uploadImages1(images: images);
  }

  static Future<List<ImageResponse>> uploadImages(
    List<Uint8List> images,
    int locationId,
  ) async {
    return await ImageRepository.uploadImages(images, locationId: locationId);
  }

  static Future<LocationBaseResponse> patchLocationThumbnail(
    int locationId,
    int imageId,
  ) async {
    UpdateThumbnailRequest updateThumbnailRequest = UpdateThumbnailRequest(
      imageId: imageId,
    );
    return await ImageRepository.patchLocationThumbnail(
      locationId,
      updateThumbnailRequest,
    );
  }
}
