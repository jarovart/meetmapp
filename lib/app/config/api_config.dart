import 'package:casttime/app/config/dev_config.dart';

class ApiConfig {
  static String _prodUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://casttime4.me',
  );

  static String get baseUrl {
    return DevConfig.devUrl ?? _prodUrl;
  }
}
