// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:casttime/program/app/di/appbanner_cubit.dart' as _i973;
import 'package:casttime/program/app/di/logger_module.dart' as _i868;
import 'package:casttime/program/app/di/network_module.dart' as _i222;
import 'package:casttime/program/app/di/storage_module.dart' as _i682;
import 'package:casttime/program/application/services/location_service.dart'
    as _i970;
import 'package:casttime/program/core/storage/secure_token_storage.dart'
    as _i699;
import 'package:casttime/program/core/storage/token_storage.dart' as _i503;
import 'package:casttime/program/data/api/auth_interceptor.dart' as _i959;
import 'package:casttime/program/data/api/locationapi.dart' as _i730;
import 'package:casttime/program/data/api/logging_interceptor.dart' as _i751;
import 'package:casttime/program/data/repositories/location_repository.dart'
    as _i988;
import 'package:casttime/program/data/repositories/location_repositoryimpl.dart'
    as _i109;
import 'package:casttime/program/domain/exceptions/apifailuremapper.dart'
    as _i201;
import 'package:casttime/program/presentation/bloc/mapbloc.dart' as _i221;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final loggerModule = _$LoggerModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i973.AppBannerCubit>(() => _i973.AppBannerCubit());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.provideFlutterSecureStorage(),
    );
    gh.lazySingleton<_i751.LoggingInterceptor>(
      () => _i751.LoggingInterceptor(),
    );
    gh.lazySingleton<_i503.TokenStorage>(
      () => _i699.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i959.AuthInterceptor>(
      () => _i959.AuthInterceptor(gh<_i503.TokenStorage>()),
    );
    gh.lazySingleton<_i201.ApiFailureMapper>(
      () => _i201.ApiFailureMapper(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i959.AuthInterceptor>(),
        gh<_i751.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i730.LocationApi>(
      () => networkModule.provideLocationApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i988.LocationRepository>(
      () => _i109.LocationRepositoryImpl(
        gh<_i730.LocationApi>(),
        gh<_i201.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i970.LocationService>(
      () => _i970.LocationService(gh<_i988.LocationRepository>()),
    );
    gh.lazySingleton<_i221.MapBloc>(
      () => _i221.MapBloc(gh<_i970.LocationService>()),
    );
    return this;
  }
}

class _$StorageModule extends _i682.StorageModule {}

class _$LoggerModule extends _i868.LoggerModule {}

class _$NetworkModule extends _i222.NetworkModule {}
