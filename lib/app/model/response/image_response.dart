import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/util/image_utils.dart';

class ImageResponse {
  final int id;
  final String imageUrl;

  ImageResponse({required this.id, required this.imageUrl});

  factory ImageResponse.fromMap(Map<String, dynamic> map) {
    debugPrint(map['imageUrl']?.toString() ?? "no profile url");
    final rawImage = map['imageUrl'] ?? '';
    final imageUrl = rawImage is String ? ImageUtils.toAbsolute(rawImage) : '';

    return ImageResponse(id: map['id'] as int, imageUrl: imageUrl);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'imageUrl': imageUrl};
  }
}
