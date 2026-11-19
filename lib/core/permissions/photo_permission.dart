import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPhotoPermission {
  static Future<bool> requestPhotoPermission() async {
    if (kIsWeb) return true;

    if (Platform.isIOS) {
      final status = await Permission.photos.request();

      return status.isGranted || status.isLimited;
    }

    if (Platform.isAndroid) {
      final photos = await Permission.photos.request();

      if (photos.isGranted || photos.isLimited) {
        return true;
      }

      final storage = await Permission.storage.request();

      return storage.isGranted;
    }

    return true;
  }
}
