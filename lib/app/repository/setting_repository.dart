import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/response/settings_response.dart';
import 'package:meetmaap/app/model/util/api_exception_wrapper.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/util/api_response_handler.dart';

class SettingRepository {
  static final _storage = const FlutterSecureStorage();
  static const String _settingsKey = 'user_settings';

  static Future<void> saveSettings(SettingResponse settings) async {
    final json = jsonEncode(settings.toMap());

    await _storage.write(key: _settingsKey, value: json);
  }

  static Future<SettingResponse?> getLocalSettings() async {
    final value = await _storage.read(key: _settingsKey);

    if (value == null) {
      return null;
    }

    final map = jsonDecode(value);
    return SettingResponse.fromMap(map);
  }

  static Future<void> clear() async {
    await _storage.delete(key: _settingsKey);
  }

  static Future<SettingResponse> loadSettings(int id) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/settings/me');

      final headers = await AuthRepository.authHeadersWithException();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      return SettingResponse.fromMap(body);
    });
  }
}
