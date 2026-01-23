import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class ImageRepository {
  static Future<List<String>> uploadImages(List<Uint8List> images) async {
    final token = await AuthRepository.getToken();
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/images/upload');

    final request = http.MultipartRequest('POST', uri);
    request.headers['Authorization'] = 'Bearer $token';

    for (int i = 0; i < images.length; i++) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'files',
          images[i],
          filename: 'image_$i.jpg',
          //contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    final response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode != 200) {
      throw Exception('Image upload failed');
    }

    //return List<String>.from(jsonDecode(body));
    // Backend liefert List<ImageResponse> => du extrahierst urls:
    final decoded = jsonDecode(body) as List;
    return decoded.map((e) => e['url'] as String).toList();
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
}
