import 'dart:typed_data';

import 'package:meetmaap/app/model/request/updatethumbnail_request.dart';
import 'package:meetmaap/app/model/response/image_response.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/image_repository.dart';

class ImageService {
  static Future<ImageResponse> uploadImageForUserProfile(
    Uint8List image,
  ) async {
    return await ImageRepository.uploadImageForUserProfile(image);
  }

  static Future<List<ImageResponse>> uploadImages(
    List<Uint8List> images,
    int locationId,
  ) async {
    return await ImageRepository.uploadImagesOfLocations(images, locationId);
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

  static Future<void> deleteMyProfileImage() async {
    if (!(await AuthRepository.isLoggedIn())) {
      throw Exception("Not logged in");
    }
    return await ImageRepository.deleteMyProfileImage();
  }
}
