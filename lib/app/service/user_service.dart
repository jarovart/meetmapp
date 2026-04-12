import 'dart:typed_data';

import 'package:meetmaap/app/model/request/editmyprofile_request.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/slicelist_response.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/model/response/userfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
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

  static Future<UserFullResponse> fetchFullUserByUserName(
    String username,
  ) async {
    return await UserRepository.fetchFullUserByUserName(username);
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
      await ImageService.uploadImageForUserProfile(profileImage);
    }
    UserMyProfileResponse userResponse = await UserRepository.updateMyProfile(
      request,
    );
    return userResponse;
  }

  static Future<SliceResponse<LocationBaseResponse>>
  getCreatedLocationsByUserIdPaged(
    int userId, {
    required int page,
    required int pageSize,
  }) async {
    return await UserRepository.getCreatedLocationsByUserIdPaged(
      userId,
      page: page,
      pageSize: pageSize,
    );
  }

  static Future<SliceResponse<LocationBaseResponse>>
  getJoinedLocationsByUserIdPaged(
    int userId, {
    required int page,
    required int pageSize,
  }) async {
    return await UserRepository.getJoinedLocationsByUserIdPaged(
      userId,
      page: page,
      pageSize: pageSize,
    );
  }

  static Future<SliceResponse<LocationBaseResponse>>
  getLikedLocationsByUserIdPaged(
    int userId, {
    required int page,
    required int pageSize,
  }) async {
    return await UserRepository.getLikedLocationsByUserIdPaged(
      userId,
      page: page,
      pageSize: pageSize,
    );
  }
}
