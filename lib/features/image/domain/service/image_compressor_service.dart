import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:image/image.dart' as img;

@lazySingleton
class ImageCompressorService {
  const ImageCompressorService();

  static const _maxWidth = 1280;
  static const _quality = 80;

  Future<Uint8List> compress(Uint8List bytes) async {
    if (kIsWeb) await Future.delayed(const Duration(milliseconds: 200));
    return compute(_compressInIsolate, bytes);
  }

  static Uint8List _compressInIsolate(Uint8List bytes) {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;

    final resized = img.copyResize(
      image,
      width: image.width > _maxWidth ? _maxWidth : image.width,
    );
    return Uint8List.fromList(img.encodeJpg(resized, quality: _quality));
  }
}
