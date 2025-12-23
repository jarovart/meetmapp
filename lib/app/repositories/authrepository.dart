import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/config/api_config.dart';

class AuthRepository {
  static final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'access_token';

  static Future<String?> getToken() => _storage.read(key: _tokenKey);
  static Future<void> logout() => _storage.delete(key: _tokenKey);

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> login({
    required String username,
    required String password,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/login');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (res.statusCode != 200) {
      throw Exception('Login fehlgeschlagen (${res.statusCode})');
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final token = json['token'] as String?;

    if (token == null || token.isEmpty) {
      throw Exception('Kein Token erhalten');
    }

    await _storage.write(key: _tokenKey, value: token);
  }
}
