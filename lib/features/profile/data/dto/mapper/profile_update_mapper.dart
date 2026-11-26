import 'package:casttime/features/profile/data/dto/request/update_my_profile_request_dto.dart';
import 'package:casttime/features/profile/domain/model/profile_image_change.dart';
import 'package:casttime/features/profile/domain/model/profile_update.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

extension ProfileUpdateMapper on ProfileUpdate {
  ({UpdateMyProfileRequestDTO data, MultipartFile? file}) toRequest() {
    return (
      data: UpdateMyProfileRequestDTO(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        aboutMe: aboutMe.trim(),
        removeProfileImage: imageChange is RemoveImage,
      ),
      file: switch (imageChange) {
        ReplaceImage(:final bytes) => MultipartFile.fromBytes(
          bytes,
          filename: 'profile.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
        _ => null,
      },
    );
  }
}
