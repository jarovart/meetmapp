import 'dart:typed_data';

import 'package:meetmaap/app/model/requests/editmyprofile_request.dart';
import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/user_repository.dart';
import 'package:meetmaap/app/service/image_service.dart';

class UserService {
  static Future<List<UserBaseResponse>> fetchUsersByQuery(String query) async {
    if (query.isNotEmpty) {
      return await UserRepository.fetchUsersByQuery(query);
    }
    return await UserRepository.fetchAllUsers();
  }

  static Future<UserFullResponse> fetchFullUserById(int id) async {
    return await UserRepository.fetchFullUserById(id);
  }

  static Future<UserFullResponse> fetchFullUserByUserName(int id) async {
    return await UserRepository.fetchFullUserById(id);
  }

  static Future<UserFullResponse> fetchFullUser(UserBaseResponse user) async {
    return await UserRepository.fetchFullUserById(user.id);
  }

  static Future fetchMyProfile() async {
    return await UserRepository.fetchMyProfile();
  }

  static Future updateMyProfile(
    EditMyProfileRequest request,
    Uint8List? profileImage,
    bool removeCurrentImage,
  ) async {
    if (removeCurrentImage) {
      await ImageService.deleteMyProfileImage();
    } else if (profileImage != null && profileImage.isNotEmpty) {
      await ImageService.uploadImage(profileImage);
    }
    UserMyProfileResponse userResponse = await UserRepository.updateMyProfile(
      request,
    );
    return userResponse;
  }
}
