// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:casttime/app/di/modules/logger_module.dart' as _i186;
import 'package:casttime/app/di/modules/network_module.dart' as _i585;
import 'package:casttime/app/di/modules/storage_module.dart' as _i587;
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart' as _i711;
import 'package:casttime/core/failure/api_failure_mapper.dart' as _i993;
import 'package:casttime/core/network/auth_interceptor.dart' as _i938;
import 'package:casttime/core/network/logging_interceptor.dart' as _i994;
import 'package:casttime/core/storage/secure_token_storage.dart' as _i137;
import 'package:casttime/core/storage/token_storage.dart' as _i511;
import 'package:casttime/features/auth/data/repository/auth_repository_impl.dart'
    as _i17;
import 'package:casttime/features/auth/data/service/auth_service_impl.dart'
    as _i555;
import 'package:casttime/features/auth/domain/repository/auth_repository.dart'
    as _i357;
import 'package:casttime/features/auth/domain/service/auth_service.dart'
    as _i976;
import 'package:casttime/features/auth/presentation/bloc/auth_bloc.dart'
    as _i453;
import 'package:casttime/features/location/data/api/locationapi.dart' as _i511;
import 'package:casttime/features/location/data/repository/location_repository_impl.dart'
    as _i113;
import 'package:casttime/features/location/data/service/location_service_impl.dart'
    as _i449;
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart'
    as _i310;
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart'
    as _i283;
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart' as _i197;
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
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.provideFlutterSecureStorage(),
    );
    gh.lazySingleton<_i711.AppBannerCubit>(() => _i711.AppBannerCubit());
    gh.lazySingleton<_i994.LoggingInterceptor>(
      () => _i994.LoggingInterceptor(),
    );
    gh.lazySingleton<_i511.TokenStorage>(
      () => _i137.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i357.AuthRepository>(() => _i17.AuthRepositoryImpl());
    gh.lazySingleton<_i993.ApiFailureMapper>(
      () => _i993.ApiFailureMapper(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i938.AuthInterceptor>(
      () => _i938.AuthInterceptor(gh<_i511.TokenStorage>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i938.AuthInterceptor>(),
        gh<_i994.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i976.AuthService>(
      () => _i555.AuthServiceImpl(gh<_i357.AuthRepository>()),
    );
    gh.lazySingleton<_i511.LocationApi>(
      () => networkModule.provideLocationApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i453.AuthBloc>(
      () => _i453.AuthBloc(gh<_i976.AuthService>()),
    );
    gh.lazySingleton<_i310.LocationRepository>(
      () => _i113.LocationRepositoryImpl(
        gh<_i511.LocationApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i283.LocationService>(
      () => _i449.LocationServiceImpl(gh<_i310.LocationRepository>()),
    );
    gh.lazySingleton<_i197.MapBloc>(
      () => _i197.MapBloc(gh<_i283.LocationService>()),
    );
    return this;
  }
}

class _$StorageModule extends _i587.StorageModule {}

class _$LoggerModule extends _i186.LoggerModule {}

class _$NetworkModule extends _i585.NetworkModule {}
