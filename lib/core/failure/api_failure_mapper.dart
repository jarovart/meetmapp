import 'package:casttime/core/error/apierror_dto.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class ApiFailureMapper {
  const ApiFailureMapper(this._logger);

  final Logger _logger;

  AppFailure map(Object error, StackTrace stackTrace) {
    if (error is! DioException) {
      return UnexpectedFailure(cause: error);
    }

    final requestId = _extractRequestId(error);

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => ConnectionTimeoutFailure(
        requestId: requestId,
        cause: error,
      ),

      DioExceptionType.connectionError => NoConnectionFailure(
        requestId: requestId,
        cause: error,
      ),

      DioExceptionType.badResponse => _mapResponseFailure(error, requestId),

      DioExceptionType.cancel => UnexpectedFailure(
        requestId: requestId,
        cause: error,
      ),

      _ => UnexpectedFailure(requestId: requestId, cause: error),
    };
  }

  AppFailure _mapResponseFailure(DioException exception, String? requestId) {
    final statusCode = exception.response?.statusCode;
    final errorDto = _parseErrorDto(exception.response?.data);
    _logger.e(
      "API Fehler",
      error: errorDto,
      //stackTrace: errorDto?.message ?? '',
    );

    return switch (statusCode) {
      400 => ValidationFailure(
        fieldErrors: errorDto?.fieldErrors ?? const {},
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),

      401 => UnauthorizedFailure(
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),

      403 => ForbiddenFailure(
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),

      404 => NotFoundFailure(
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),

      409 => ConflictFailure(
        code: errorDto?.code,
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),

      500 || 502 || 503 || 504 => ServerUnavailableFailure(
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),

      _ => UnexpectedFailure(
        requestId: errorDto?.requestId ?? requestId,
        cause: exception,
      ),
    };
  }

  ApiErrorDTO? _parseErrorDto(Object? data) {
    if (data is! Map<String, dynamic>) {
      return null;
    }

    try {
      return ApiErrorDTO.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  String? _extractRequestId(DioException exception) {
    return exception.response?.headers.value('x-request-id');
  }
}
