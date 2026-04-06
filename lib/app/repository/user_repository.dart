import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/request/editmyprofile_request.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/model/response/userfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/model/util/api_exception_wrapper.dart';
import 'package:meetmaap/app/repository/util/api_response_handler.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class UserRepository {
  static Future<List<UserBaseResponse>> fetchUsersByQuery(String query) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/query',
      ).replace(queryParameters: {'query': query});

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonList(response);
      return body.map((e) => UserBaseResponse.fromMap(e)).toList();
    });
  }

  static Future<List<UserBaseResponse>> fetchAllUsers() async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/all');

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonList(response);
      return body.map((e) => UserBaseResponse.fromMap(e)).toList();
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
      final headers = await AuthRepository.authHeaders();
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
}
