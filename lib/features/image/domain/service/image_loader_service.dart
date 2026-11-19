import 'dart:typed_data';

import 'package:casttime/features/image/domain/model/app_image.dart';
import 'package:casttime/features/image/domain/model/image_entry.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ImageLoaderService {
  const ImageLoaderService(@Named('images') this._dio);

  final Dio _dio;

  Future<List<ImageEntry>> loadExisting(List<AppImage> images) async {
    final entries = <ImageEntry>[];

    for (final image in images) {
      try {
        final response = await _dio.get<List<int>>(
          image.imageUrl,
          options: Options(responseType: ResponseType.bytes),
        );
        final bytes = response.data;
        if (bytes != null) {
          entries.add(
            ImageEntry.existing(id: image.id, bytes: Uint8List.fromList(bytes)),
          );
        }
      } catch (_) {
        // Einzelnes Bild übersprungen — der Rest bleibt nutzbar
      }
    }
    return entries;
  }
}
