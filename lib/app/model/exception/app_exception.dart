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

class AppNetworkException extends AppException {
  const AppNetworkException({super.debugMessage});

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
