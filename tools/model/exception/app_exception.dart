import 'package:latlong2/latlong.dart';

abstract class AppException implements Exception {
  final String? debugMessage;

  const AppException({this.debugMessage});
}

class AppHttpException extends AppException {
  final int statusCode;
  final String? serverMessage;
  final String? errorCode;
  final Map<String, dynamic>? body;

  const AppHttpException({
    required this.statusCode,
    this.serverMessage,
    this.errorCode,
    this.body,
    super.debugMessage,
  });

  @override
  String toString() {
    return 'AppHttpException('
        'statusCode: $statusCode, '
        'errorCode: $errorCode, '
        'serverMessage: $serverMessage, '
        'debugMessage: $debugMessage'
        ')';
  }
}

class CooldownException extends AppHttpException {
  final int seconds;

  const CooldownException({
    required super.statusCode,
    super.serverMessage,
    super.errorCode,
    super.body,
    super.debugMessage,
    required this.seconds,
  });

  @override
  String toString() {
    return 'CooldownException('
        'statusCode: $statusCode, '
        'errorCode: $errorCode, '
        'serverMessage: $serverMessage, '
        'debugMessage: $debugMessage, '
        'seconds: $seconds'
        ')';
  }
}

class AppNetworkException extends AppException {
  final Exception originException;
  const AppNetworkException({
    super.debugMessage,
    required this.originException,
  });

  @override
  String toString() => 'AppNetworkException(debugMessage: $debugMessage)';
}

class AppUnknownException extends AppException {
  const AppUnknownException({super.debugMessage});

  @override
  String toString() => 'AppUnknownException(debugMessage: $debugMessage)';
}

class NotLoggedInException extends AppException {
  const NotLoggedInException({super.debugMessage});

  @override
  String toString() => 'NotLoggedInException(debugMessage: $debugMessage)';
}

abstract class CustomAppException extends AppException {
  @override
  String toString() => 'CustomAppException(debugMessage: $debugMessage)';
}

class LocationCouldNotBeLoadedException extends CustomAppException {}

sealed class LocationResult extends CustomAppException {
  LocationResult();
}

class LocationSuccess extends LocationResult {
  final LatLng position;
  LocationSuccess(this.position);
}

class LocationPermissionDenied extends LocationResult {
  LocationPermissionDenied();
}

class LocationServiceDisabled extends LocationResult {
  LocationServiceDisabled();
}

class LocationError extends LocationResult {
  final String message;
  LocationError(this.message);
}

class NoTokenException extends CustomAppException {}

class InvalidLocationIdException extends CustomAppException {}

class NotLocationOwnerNoEditException extends CustomAppException {}

class FillAllFieldsException extends CustomAppException {}

class InfoChooseStartAndEnddateException extends CustomAppException {}

class InfoEnddateBeforeStartdateException extends CustomAppException {}

class ValidEmailHintException extends CustomAppException {}

class NotMatchPasswordsException extends CustomAppException {}

class Atleast8CharPasswordException extends CustomAppException {}

class EmailInvalidException extends CustomAppException {}

class NoGpsAndNoFilterLocationException extends CustomAppException {}
