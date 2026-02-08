import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/responses/userbase_response.dart';

class UserRepository {
  static Future<List<UserBaseResponse>> fetchUsersByQuery(String query) async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/users/query',
    ).replace(queryParameters: {'query': query});

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load user by query');
    }
    final body = jsonDecode(response.body) as List;
    return body.map((e) => UserBaseResponse.fromMap(e)).toList();
  }

  static Future<List<UserBaseResponse>> fetchAllUsers() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/users/all');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load all users');
    }
    debugPrint("was geht: ${response.body}");
    final body = jsonDecode(response.body) as List;
    return body.map((e) => UserBaseResponse.fromMap(e)).toList();
  }
}
