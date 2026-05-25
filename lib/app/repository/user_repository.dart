import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/request/editmyprofile_request.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/slicelist_response.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/model/response/userfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/model/util/api_exception_wrapper.dart';
import 'package:meetmaap/app/repository/util/api_response_handler.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class UserRepository {
  static Future<SliceResponse<UserBaseResponse>> fetchUsersByQuery(
    String query,
    int page,
    int pageSize,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/findByQuery?query=$query&page=$page&size=$pageSize',
      );

      final headers = await AuthRepository.authHeadersWithException();
      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonMap(response);
      return SliceResponse.fromMap(
        decoded,
        (item) => UserBaseResponse.fromMap(item),
      );
    });
  }

  static Future<SliceResponse<UserBaseResponse>> fetchAllUsers(
    int page,
    int pageSize,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/all?page=$page&size=$pageSize',
      );

      final headers = await AuthRepository.authHeadersWithException();
      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonMap(response);
      return SliceResponse.fromMap(
        decoded,
        (item) => UserBaseResponse.fromMap(item),
      );
    });
  }

  static Future<UserFullResponse> fetchFullUserById(int id) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/findById',
      ).replace(queryParameters: {'id': id.toString()});

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      return UserFullResponse.fromMap(body);
    });
  }

  static Future<UserFullResponse> fetchFullUserByUserName(
    String username,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/findByUsername',
      ).replace(queryParameters: {'username': username});

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      return UserFullResponse.fromMap(body);
    });
  }

  static Future<UserMyProfileResponse> fetchMyProfile() async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/me');

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      debugPrint("my profile data: $body");
      return UserMyProfileResponse.fromMap(body);
    });
  }

  static Future<UserMyProfileResponse> updateMyProfile(
    EditMyProfileRequest request,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/me');
      final headers = await AuthRepository.authHeadersWithException();
      final response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(request.toMap()),
      );

      final body = ApiResponseHandler.parseJsonObject(response);
      final updatedProfile = UserMyProfileResponse.fromMap(body);

      await AuthRepository.saveMyProfile(updatedProfile);
      return updatedProfile;
    });
  }

  static Future<SliceResponse<LocationBaseResponse>>
  getCreatedLocationsByUserIdPaged(
    int userId, {
    required int page,
    required int pageSize,
  }) async {
    return ApiExceptionWrapper.guard(() async {
      final headers = await AuthRepository.authHeadersWithException();
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/$userId/locations/created?page=$page&size=$pageSize',
      );
      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonMap(response);
      return SliceResponse.fromMap(
        decoded,
        (item) => LocationBaseResponse.fromMap(item),
      );
    });
  }

  static Future<SliceResponse<LocationBaseResponse>>
  getJoinedLocationsByUserIdPaged(
    int userId, {
    required int page,
    required int pageSize,
  }) async {
    return ApiExceptionWrapper.guard(() async {
      final headers = await AuthRepository.authHeadersWithException();

      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/$userId/locations/joined?page=$page&size=$pageSize',
      );

      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonMap(response);
      return SliceResponse.fromMap(
        decoded,
        (item) => LocationBaseResponse.fromMap(item),
      );
    });
  }

  static Future<SliceResponse<LocationBaseResponse>>
  getLikedLocationsByUserIdPaged(
    int userId, {
    required int page,
    required int pageSize,
  }) async {
    return ApiExceptionWrapper.guard(() async {
      final headers = await AuthRepository.authHeadersWithException();

      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/$userId/locations/liked?page=$page&size=$pageSize',
      );

      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonMap(response);
      return SliceResponse.fromMap(
        decoded,
        (item) => LocationBaseResponse.fromMap(item),
      );
    });
  }
}
