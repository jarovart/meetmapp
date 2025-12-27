import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/model/exceptions/cooldownexception.dart';
import 'package:meetmaap/config/api_config.dart';

class AuthRepository {
  static final _storage = const FlutterSecureStorage();
  static const _tokenKey = 'access_token';
  static const _usernameKey = 'username';

  static Future<String?> getToken() => _storage.read(key: _tokenKey);
  static Future<void> logout() => _storage.delete(key: _tokenKey);
  static Future<String?> getUsername() => _storage.read(key: _usernameKey);

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
    final loginname = json['username'] as String?;

    if (token == null || token.isEmpty) {
      throw Exception('Kein Token erhalten');
    }

    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _usernameKey, value: loginname);
  }

  static Future<void> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/register');

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      }),
    );

    if (res.statusCode == 429) {
      final body = jsonDecode(res.body);
      final message = body['message'];
      final seconds = body['secondsUntilNextMailAllowed'] as int;
      throw CooldownException(message, seconds);
    }

    if (res.statusCode != 200) {
      throw Exception(
        'Registrierung fehlgeschlagen (${res.statusCode}): ${res.body}',
      );
    }
  }

  static Future<void> verify(String token) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/verify');

    final res = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'token': token}),
        )
        .timeout(const Duration(seconds: 10));

    if (res.statusCode == 200) {
      // ✅ alles gut
      return;
    }

    if (res.statusCode == 410) {
      throw Exception('Verifizierungslink ist abgelaufen');
    }

    if (res.statusCode == 400) {
      throw Exception('Ungültiger oder bereits verwendeter Link');
    }

    throw Exception('Verifizierung fehlgeschlagen (${res.statusCode})');
  }

  static Future<void> resendVerificationEmail({required String email}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/resend-verification');

    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (res.statusCode == 200) {
      return;
    }

    if (res.statusCode == 429) {
      final body = jsonDecode(res.body);
      final message = body['message'];
      final seconds = body['secondsUntilNextMailAllowed'] as int;
      throw CooldownException(message, seconds);
    }

    throw Exception(
      res.body.isNotEmpty
          ? res.body
          : 'E-Mail konnte nicht erneut gesendet werden',
    );
  }

  static Future<void> forgotPassword({required String email}) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/forgot-password');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (res.statusCode == 200) return;
    if (res.statusCode == 429) {
      final body = jsonDecode(res.body);
      final message = body['message'];
      final seconds = body['secondsUntilNextMailAllowed'] as int;
      throw CooldownException(message, seconds);
    }
    throw Exception('Fehler (${res.statusCode}): ${res.body}');
  }

  static Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/auth/reset-password');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'newPassword': newPassword}),
    );

    if (res.statusCode == 200) return;
    if (res.statusCode == 410) throw Exception('Link ist abgelaufen');
    if (res.statusCode == 400) throw Exception(res.body);
    throw Exception('Fehler (${res.statusCode}): ${res.body}');
  }
}
