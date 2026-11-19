import 'package:casttime/app/config/api_config.dart';
import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/core/network/logging_interceptor.dart';
import 'package:casttime/features/auth/data/api/auth_api.dart';
import 'package:casttime/features/image/data/api/image_api.dart';
import 'package:casttime/features/info/data/api/info_api.dart';
import 'package:casttime/features/location/data/api/geocoding_api.dart';
import 'package:casttime/features/location/data/api/location_api.dart';
import 'package:casttime/features/location/data/api/place_api.dart';
import 'package:casttime/features/profile/data/api/user_profile_api.dart';
import 'package:casttime/features/setting/data/api/settings_api.dart';
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

  @Named('geocoding')
  @lazySingleton
  Dio provideGeocodingDio() {
    return Dio(
      BaseOptions(
        headers: {'User-Agent': 'casttime-app/1.0 (info@jarovart.de)'},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  @lazySingleton
  LocationApi provideLocationApi(Dio dio) {
    return LocationApi(dio);
  }

  @lazySingleton
  AuthApi provideAuthApi(Dio dio) => AuthApi(dio);

  @lazySingleton
  UserProfileApi provideProfileApi(Dio dio) => UserProfileApi(dio);

  @lazySingleton
  PlaceApi providePlaceApi(Dio dio) => PlaceApi(dio);

  @lazySingleton
  InfoApi provideInfoApi(Dio dio) => InfoApi(dio);

  @lazySingleton
  SettingsApi provideSettingsApi(Dio dio) => SettingsApi(dio);

  @lazySingleton
  ImageApi provideImageApi(Dio dio) => ImageApi(dio);

  @lazySingleton
  GeocodingApi provideGeocodingApi(@Named('geocoding') Dio dio) =>
      GeocodingApi(dio);

  @Named('images')
  @lazySingleton
  Dio provideImagesDio() {
    return Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
