import 'package:casttime/app/di/injection.dart';
import 'package:casttime/core/storage/token_storage.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;
  static const withAuthentication = 'withAuthentication';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final withAuth = options.extra[withAuthentication] == true;

    if (withAuth) {
      final session = await _tokenStorage.readSession();
      if (session != null) {
        options.headers['Authorization'] =
            'Bearer ${session.tokens.accessToken}';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await getIt<AuthCubit>().refreshTokenIfNeeded();
      if (refreshed) {
        final session = await _tokenStorage.readSession();
        if (session != null) {
          err.requestOptions.headers['Authorization'] =
              'Bearer ${session.tokens.accessToken}';
          final response = await Dio().fetch(err.requestOptions);
          debugPrint("Token refreshed, retrying request");
          return handler.resolve(response);
        }
      }
    }
    handler.next(err);
  }
}
