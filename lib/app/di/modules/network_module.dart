import 'package:casttime/app/config/api_config.dart';
import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/core/network/logging_interceptor.dart';
import 'package:casttime/features/location/data/api/locationapi.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(
    AuthInterceptor authInterceptor,
    LoggingInterceptor loggingInterceptor,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(loggingInterceptor);

    return dio;
  }

  @lazySingleton
  LocationApi provideLocationApi(Dio dio) {
    return LocationApi(dio);
  }
}
