import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:casttime/app/model/exception/app_exception.dart';

class ApiResponseHandler {
  static void ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    String? serverMessage;
    String? errorCode;
    Map<String, dynamic>? body;

    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        body = decoded;
        serverMessage = decoded['message']?.toString();
        errorCode = decoded['code']?.toString();
      }
    } catch (e) {
      // absichtlich ignorieren
    }

    if (response.statusCode == 429) {
      final seconds = body?['secondsUntilNextMailAllowed'] ?? 0;
      throw CooldownException(
        statusCode: response.statusCode,
        serverMessage: serverMessage,
        errorCode: errorCode,
        body: body,
        debugMessage: response.body,
        seconds: seconds,
      );
    }

    throw AppHttpException(
      statusCode: response.statusCode,
      serverMessage: serverMessage,
      errorCode: errorCode,
      body: body,
      debugMessage: response.body,
    );
  }

  static Map<String, dynamic> parseJsonObject(http.Response response) {
    ensureSuccess(response);

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw AppUnknownException(
        debugMessage: 'Expected JSON object but got: ${response.body}',
      );
    }

    return decoded;
  }

  static List<dynamic> parseJsonList(http.Response response) {
    ensureSuccess(response);

    final decoded = jsonDecode(response.body);
    if (decoded is! List<dynamic>) {
      throw AppUnknownException(
        debugMessage: 'Expected JSON list but got: ${response.body}',
      );
    }

    return decoded;
  }

  static Map<String, dynamic> parseJsonMap(http.Response response) {
    ensureSuccess(response);

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw AppUnknownException(
        debugMessage: 'Expected JSON Map but got: ${response.body}',
      );
    }

    return decoded;
  }
}
