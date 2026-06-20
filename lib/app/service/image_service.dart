import 'dart:typed_data';

import 'package:casttime/app/model/exception/app_exception.dart';
import 'package:casttime/app/model/request/updatethumbnail_request.dart';
import 'package:casttime/app/model/response/image_response.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/app/repository/authentication_repository.dart';
import 'package:casttime/app/repository/image_repository.dart';

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
      throw NotLoggedInException();
    }
    return await ImageRepository.deleteMyProfileImage();
  }
}
