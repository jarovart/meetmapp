import 'package:http/http.dart' as http;
import 'package:meetmaap/app/repositories/AuthRepository.dart';
import 'package:meetmaap/config/api_config.dart';

class ApiClient {
  static Future<http.Response> get(String path) async {
    final token = await AuthRepository.getToken();
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    return http.get(uri, headers: _headers(token));
  }

  static Future<http.Response> post(String path, {Object? body}) async {
    final token = await AuthRepository.getToken();
    final uri = Uri.parse('${ApiConfig.baseUrl}$path');
    return http.post(uri, headers: _headers(token), body: body);
  }

  static Map<String, String> _headers(String? token) {
    final h = <String, String>{'Content-Type': 'application/json'};
    if (token != null && token.isNotEmpty) {
      h['Authorization'] = 'Bearer $token';
    }
    return h;
  }
}
