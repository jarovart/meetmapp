import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/response/place_response.dart';
import 'package:meetmaap/app/model/util/api_exception_wrapper.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/util/api_response_handler.dart';

class PlaceRepository {
  static Future<List<PlaceResponse>> fetchSuggestedPlace(
    String placeNameQuery,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/places?query=$placeNameQuery',
      );

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonList(response);
      return decoded.map((e) => PlaceResponse.fromMap(e)).toList();
    });
  }
}
