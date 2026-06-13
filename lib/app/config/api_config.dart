import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

class ApiConfig {
  static const int _port = 8080;
  static const String _dev = String.fromEnvironment('dev', defaultValue: '');

  static String get baseUrl {
    debugPrint("api base url: $_dev");
    return (_dev.isNotEmpty) ? baseUrl1 : 'https://freemoment.de';
  }

  static String get baseUrl1 {
    // 🌐 Flutter Web
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
