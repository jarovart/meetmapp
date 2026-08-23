import 'dart:async';

import 'package:casttime/core/failure/app_failure.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class LocationFailureMapper {
  const LocationFailureMapper(this._logger);

  final Logger _logger;

  AppFailure map(Object error, StackTrace stackTrace) {
    _logger.e('Location error', error: error, stackTrace: stackTrace);

    return switch (error) {
      LocationServiceDisabledException() =>
        const LocationServiceDisabledFailure(),
      PermissionDeniedException() => const LocationPermissionDeniedFailure(),
      TimeoutException() => const LocationTimeoutFailure(),
      _ => UnexpectedFailure(cause: error),
    };
  }
}
