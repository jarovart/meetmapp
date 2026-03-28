import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/requests/updatethumbnail_request.dart';
import 'package:meetmaap/app/model/responses/image_response.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class ImageRepository {
  static Future<List<String>> uploadImages1({
    required List<Uint8List> images,
    int? locationId,
  }) async {
    final token = await AuthRepository.getToken();
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/upload');

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    if (locationId != null) {
      request.fields['locationId'] = locationId.toString();
    }

    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'files',
          images[i],
          filename: 'image_$i.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Image upload failed (${response.statusCode}): $body');
    }

    //return List<String>.from(jsonDecode(body));
    // Backend liefert List<ImageResponse> => du extrahierst urls:
    final decoded = jsonDecode(body) as List;
    //return decoded.map((e) => e['url'] as String).toList();
    return decoded.cast<String>();
  }

  static Future<List<ImageResponse>> uploadImages(
    List<Uint8List> images, {
    int? locationId,
  }) async {
    if (images.isEmpty) {
      throw Exception('No images to upload');
    }
    final token = await AuthRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Not authenticated');
    }

    final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/uploadImages');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    if (locationId != null) {
      request.fields['locationId'] = locationId.toString();
    }

    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'files',
          images[i],
          filename: 'image_$i.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Image upload failed (${response.statusCode}): $body');
    }

    final decoded = jsonDecode(body) as List;
    return decoded
        .map((e) => ImageResponse.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> uploadImageByBytes(
    List<int> imageBytes,
    int index,
  ) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/upload');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: 'image_$index.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Upload failed');
    }
  }

  Future<void> deleteImageFromServer(int imageId) async {
    await http.delete(Uri.parse('${ApiConfig.baseUrl}/api/images/$imageId'));
  }

  static Future<LocationBaseResponse> patchLocationThumbnail(
    int locationId,
    UpdateThumbnailRequest updateThumbnailRequest,
  ) async {
    final token = await AuthRepository.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Not authenticated');
    }

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/$locationId/thumbnail',
    );
    final response = await http.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updateThumbnailRequest.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Patch thumbnail failed (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return LocationBaseResponse.fromMap(decoded);
  }
}
