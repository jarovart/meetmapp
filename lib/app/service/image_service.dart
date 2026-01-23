import 'dart:typed_data';

import 'package:meetmaap/app/repository/image_repository.dart';

class ImageService {
  static Future<List<String>> uploadImages(List<Uint8List> images) async {
    return ImageRepository.uploadImages(images);
  }
}
