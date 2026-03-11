import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class UserRepository {
  static Future<Map<String, String>> _authHeaders() async {
    final token = await AuthRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Not logged in (missing token)');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<List<UserBaseResponse>> fetchUsersByQuery(String query) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/users/query',
    ).replace(queryParameters: {'query': query});

    final headers = await _authHeaders();
    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to load user by query');
    }
    final body = jsonDecode(response.body) as List;
    return body.map((e) => UserBaseResponse.fromMap(e)).toList();
  }

  static Future<List<UserBaseResponse>> fetchAllUsers() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/all');

    final headers = await _authHeaders();
    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to load all users');
    }
    debugPrint("was geht: ${response.body}");
    final body = jsonDecode(response.body) as List;
    return body.map((e) => UserBaseResponse.fromMap(e)).toList();
  }

  static Future<UserFullResponse> fetchFullUserById(int id) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/users/findById',
    ).replace(queryParameters: {'id': id.toString()});

    final headers = await _authHeaders();
    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to load user by id');
    }
    final body = jsonDecode(response.body);
    return UserFullResponse.fromMap(body);
  }

  static Future<UserMyProfileResponse> fetchMyProfile() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/me');

    final headers = await _authHeaders();
    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load my profile (${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    debugPrint("my profile data: $body");
    return UserMyProfileResponse.fromMap(body);
  }

  static Future<UserMyProfileResponse> updateMyProfile({
    required String firstName,
    required String lastName,
    required String aboutMe,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/me');

    final headers = await _authHeaders();
    final response = await http.patch(
      uri,
      headers: headers,
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'aboutMe': aboutMe,
      }),
    );

    if (response.statusCode != 200) {
      debugPrint(
        "Failed to update my profile (${response.statusCode}): ${response.body}",
      );
      throw Exception(
        'Failed to update my profile (${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final updatedProfile = UserMyProfileResponse.fromMap(body);

    await AuthRepository.saveMyProfile(updatedProfile);

    return updatedProfile;
  }
}
