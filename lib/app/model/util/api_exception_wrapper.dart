import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meetmaap/app/model/exception/app_exception.dart';

class ApiExceptionWrapper {
  static Future<T> guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on AppException {
      rethrow;
    } on SocketException catch (e) {
      throw AppNetworkException(debugMessage: e.toString(), originException: e);
    } on TimeoutException catch (e) {
      throw AppNetworkException(debugMessage: e.toString(), originException: e);
    } on http.ClientException catch (e) {
      throw AppNetworkException(debugMessage: e.toString(), originException: e);
    } on FormatException catch (e) {
      throw AppUnknownException(debugMessage: e.toString());
    } catch (e) {
      throw AppUnknownException(debugMessage: e.toString());
    }
  }
}
