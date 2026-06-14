import 'package:meetmaap/app/config/dev_config.dart';

class ApiConfig {
  static const String prodUrl = 'https://freemoment.de';

  static String get baseUrl {
    return DevConfig.devUrl ?? prodUrl;
  }
}
