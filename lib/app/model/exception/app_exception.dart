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

class CustomAppException extends AppException {
  const CustomAppException([String? debugMessage])
    : super(debugMessage: debugMessage);

  @override
  String toString() => 'CustomAppException(debugMessage: $debugMessage)';
  String get message => debugMessage ?? '';
}
