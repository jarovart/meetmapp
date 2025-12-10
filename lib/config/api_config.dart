import 'package:flutter/foundation.dart';

class ApiConfig {
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost:8080"; // Web/Chrome
    } else {
      return "http://10.0.2.2:8080"; // Android Emulator
    }
  }
}
