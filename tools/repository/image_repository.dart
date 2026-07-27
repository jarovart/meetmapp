import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:casttime/app/config/api_config.dart';
import 'package:casttime/app/model/request/updatethumbnail_request.dart';
import 'package:casttime/app/model/response/image_response.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/app/model/util/api_exception_wrapper.dart';
import 'package:casttime/app/repository/util/api_response_handler.dart';
import 'package:casttime/app/repository/authentication_repository.dart';

class ImageRepository {
  static Future<ImageResponse> uploadImageForUserProfile(
    Uint8List image,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/me');
      final headers = await AuthRepository.authHeadersWithException();
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          image,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final decoded = ApiResponseHandler.parseJsonObject(response);
      return ImageResponse.fromMap(decoded);
    });
  }

  static Future<List<ImageResponse>> uploadImagesOfLocations(
    List<Uint8List> images,
    int locationId,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      if (images.isEmpty) {
        throw Exception('No images to upload');
      }
      final headers = await AuthRepository.authHeadersWithException();

      final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/uploadImages');
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields['locationId'] = locationId.toString();

      for (int i = 0; i < images.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'files',
            images[i],
            filename: 'image_$i.jpg',
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final decoded = ApiResponseHandler.parseJsonList(response);
      return decoded
          .map((e) => ImageResponse.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  static Future<LocationBaseResponse> patchLocationThumbnail(
    int locationId,
    UpdateThumbnailRequest updateThumbnailRequest,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final headers = await AuthRepository.authHeadersWithException();
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/$locationId/thumbnail',
      );
      final response = await http.patch(
        uri,
        headers: headers,
        body: jsonEncode(updateThumbnailRequest.toMap()),
      );

      final decoded = ApiResponseHandler.parseJsonObject(response);
      return LocationBaseResponse.fromMap(decoded);
    });
  }

  static Future<void> deleteMyProfileImage() async {
    return ApiExceptionWrapper.guard(() async {
      final headers = await AuthRepository.authHeadersWithException();
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/me');
      final response = await http.delete(uri, headers: headers);

      ApiResponseHandler.ensureSuccess(response);
    });
  }
}
