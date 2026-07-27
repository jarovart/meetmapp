import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:casttime/app/config/api_config.dart';
import 'package:casttime/app/model/request/settings_request.dart';
import 'package:casttime/app/model/response/settings_response.dart';
import 'package:casttime/app/model/util/api_exception_wrapper.dart';
import 'package:casttime/app/repository/authentication_repository.dart';
import 'package:casttime/app/repository/util/api_response_handler.dart';

class SettingRepository {
  static final _storage = const FlutterSecureStorage();
  static const String _settingsKey = 'user_settings';

  static Future<SettingsResponse> saveLocalSettings(
    SettingsRequest settings,
  ) async {
    final json = jsonEncode(settings.toMap());
    debugPrint("saved prelocal setting: $json");

    await _storage.write(key: _settingsKey, value: json);
    final map = jsonDecode(json);
    debugPrint("saved local setting: $map");
    return SettingsResponse.fromMap(map);
  }

  static Future<SettingsResponse> saveSettings(SettingsRequest settings) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/settings/me');

      final headers = await AuthRepository.authHeadersWithException();
      final response = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(settings.toMap()),
      );

      final body = ApiResponseHandler.parseJsonObject(response);
      debugPrint("savesettingresponse $body");
      return SettingsResponse.fromMap(body);
    });
  }

  static Future<SettingsResponse?> getLocalSettings() async {
    final value = await _storage.read(key: _settingsKey);

    if (value == null) {
      return null;
    }

    final map = jsonDecode(value);
    return SettingsResponse.fromMap(map);
  }

  static Future<void> clear() async {
    await _storage.delete(key: _settingsKey);
  }

  static Future<SettingsResponse> loadSettings(int id) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/settings/me');

      final headers = await AuthRepository.authHeadersWithException();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      debugPrint("loadsettingsresponse: $body");
      return SettingsResponse.fromMap(body);
    });
  }
}
