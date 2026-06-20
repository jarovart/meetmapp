import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/response/status_response.dart';
import 'package:meetmaap/app/model/util/api_exception_wrapper.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/util/api_response_handler.dart';

class InfoRepository {
  static Future<StatusResponse> getHealth() async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/info/status');

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      debugPrint("gethealth $body");
      return StatusResponse.fromMap(body);
    });
  }

  static Future<StatusResponse> getFullHealth() async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/info/fullStatus');

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      debugPrint("gethealth $body");
      return StatusResponse.fromMap(body);
    });
  }
}
