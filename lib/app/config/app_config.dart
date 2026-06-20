import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConfig {
  static const int checkLoginIntervalInSeconds = 30;
  static const String appName = "FreeMoment";
  static const String version = '$major.$minor.$patch';
  static const String major = '0';
  static const String minor = '0';
  static const String patch = '1';

  static bool isMobile() {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
}
