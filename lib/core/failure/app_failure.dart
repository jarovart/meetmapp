sealed class AppFailure {
  const AppFailure({this.requestId, this.cause});

  final String? requestId;

  /// Nur für Logs und Debugging, niemals direkt in der UI anzeigen.
  final Object? cause;
}

final class NoConnectionFailure extends AppFailure {
  const NoConnectionFailure({super.requestId, super.cause});
}

final class ConnectionTimeoutFailure extends AppFailure {
  const ConnectionTimeoutFailure({super.requestId, super.cause});
}

final class ServerUnavailableFailure extends AppFailure {
  const ServerUnavailableFailure({super.requestId, super.cause});
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure({super.requestId, super.cause});
}

final class ForbiddenFailure extends AppFailure {
  const ForbiddenFailure({super.requestId, super.cause});
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure({this.resource, super.requestId, super.cause});

  final String? resource;
}

final class ValidationFailure extends AppFailure {
  const ValidationFailure({
    required this.fieldErrors,
    super.requestId,
    super.cause,
  });

  final Map<String, String> fieldErrors;
}

final class ConflictFailure extends AppFailure {
  const ConflictFailure({this.code, super.requestId, super.cause});

  final String? code;
}

final class UnexpectedFailure extends AppFailure {
  const UnexpectedFailure({super.requestId, super.cause});
}

final class InvalidSearchQueryFailure extends AppFailure {
  const InvalidSearchQueryFailure();
}

final class InvalidDateRangeFailure extends AppFailure {
  const InvalidDateRangeFailure();
}

final class LocationPermissionDeniedFailure extends AppFailure {
  const LocationPermissionDeniedFailure({super.requestId, super.cause});
}

final class LocationPermissionDeniedForeverFailure extends AppFailure {
  const LocationPermissionDeniedForeverFailure({super.requestId, super.cause});
}

final class LocationServiceDisabledFailure extends AppFailure {
  const LocationServiceDisabledFailure({super.requestId, super.cause});
}

final class LocationTimeoutFailure extends AppFailure {
  const LocationTimeoutFailure({super.requestId, super.cause});
}
