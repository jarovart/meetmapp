import 'package:meetmaap/app/config/api_config.dart';

class ImageUtils {
  static String toAbsolute(String url) {
    if (url.isEmpty) return '';
    if (url.startsWith('http')) return url;
    return '${ApiConfig.baseUrl}$url';
  }
}
