import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConfig {
  static const int checkLoginIntervalInSeconds = 30;
  static const String appName = "MeetMapp";

  static bool isMobile() {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
}
