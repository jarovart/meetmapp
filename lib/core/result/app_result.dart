import 'package:casttime/core/failure/app_failure.dart';

sealed class AppResult<T> {
  const AppResult();

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(AppFailure failure) onFailure,
  }) {
    return switch (this) {
      Success<T>(:final data) => onSuccess(data),
      Failure<T>(:final failure) => onFailure(failure),
    };
  }
}

final class Success<T> extends AppResult<T> {
  final T data;

  const Success(this.data);
}

final class Failure<T> extends AppResult<T> {
  final AppFailure failure;

  const Failure(this.failure);
}
