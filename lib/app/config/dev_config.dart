import 'dart:io';

import 'package:flutter/foundation.dart';

class DevConfig {
  static const bool isDev = false;
  static const int _port = 8080;

  static String? get devUrl {
    // 🌐 Flutter Web
    if (!isDev) {
      return null;
    }

    if (kIsWeb) {
      return 'http://localhost:$_port';
    }

    // 📱 Mobile / Desktop
    if (Platform.isAndroid) {
      // Android Emulator
      return 'http://10.0.2.2:$_port';
    }

    if (Platform.isWindows) {
      return 'http://127.0.0.1:$_port';
    }

    if (Platform.isIOS || Platform.isMacOS) {
      return 'http://localhost:$_port';
    }

    // ❌ Fallback (sollte nie passieren)
    throw UnsupportedError('Unsupported platform');
  }
}
