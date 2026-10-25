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
import 'package:casttime/app/presentation/cubit/profile_section_cubit.dart'
    as _i337;
import 'package:casttime/core/failure/api_failure_mapper.dart' as _i993;
import 'package:casttime/core/failure/geolocation_failure_mapper.dart' as _i455;
import 'package:casttime/core/network/auth_interceptor.dart' as _i938;
import 'package:casttime/core/network/logging_interceptor.dart' as _i994;
import 'package:casttime/core/storage/preferences_repository.dart' as _i297;
import 'package:casttime/core/storage/secure_token_storage.dart' as _i137;
import 'package:casttime/core/storage/token_storage.dart' as _i511;
import 'package:casttime/features/auth/data/api/auth_api.dart' as _i401;
import 'package:casttime/features/auth/data/repository/auth_repository_impl.dart'
    as _i17;
import 'package:casttime/features/auth/domain/repository/auth_repository.dart'
    as _i357;
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart'
    as _i713;
import 'package:casttime/features/info/data/api/info_api.dart' as _i248;
import 'package:casttime/features/info/data/service/info_service_impl.dart'
    as _i559;
import 'package:casttime/features/info/domain/service/info_service.dart'
    as _i1030;
import 'package:casttime/features/info/presentation/bloc/info_bloc.dart'
    as _i144;
import 'package:casttime/features/location/data/api/location_api.dart' as _i507;
import 'package:casttime/features/location/data/api/place_api.dart' as _i8;
import 'package:casttime/features/location/data/repository/location_repository_impl.dart'
    as _i113;
import 'package:casttime/features/location/data/repository/place_repository_impl.dart'
    as _i256;
import 'package:casttime/features/location/data/service/location_service_impl.dart'
    as _i449;
import 'package:casttime/features/location/data/service/place_service_impl.dart'
    as _i881;
import 'package:casttime/features/location/domain/model/location.dart' as _i96;
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart'
    as _i310;
import 'package:casttime/features/location/domain/repositoryinterface/place_repository.dart'
    as _i702;
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart'
    as _i283;
import 'package:casttime/features/location/domain/serviceinterface/place_service.dart'
    as _i911;
import 'package:casttime/features/location/domain/util/location_bounds_calculator.dart'
    as _i794;
import 'package:casttime/features/location/presentation/bloc/locationdetail_bloc.dart'
    as _i312;
import 'package:casttime/features/location/presentation/bloc/locationlist_bloc.dart'
    as _i981;
import 'package:casttime/features/location/presentation/bloc/place_suggestion_cubit.dart'
    as _i266;
import 'package:casttime/features/location/presentation/util/sheet_size_memory.dart'
    as _i223;
import 'package:casttime/features/map/data/service/location_permission_service_impl.dart'
    as _i977;
import 'package:casttime/features/map/domain/service/location_permission_service.dart'
    as _i418;
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart' as _i197;
import 'package:casttime/features/profile/data/api/profile_api.dart' as _i523;
import 'package:casttime/features/profile/data/repository/profile_repository_impl.dart'
    as _i610;
import 'package:casttime/features/profile/data/service/profile_service_impl.dart'
    as _i420;
import 'package:casttime/features/profile/domain/model/location_list_type.dart'
    as _i607;
import 'package:casttime/features/profile/domain/repository/profile_repository.dart'
    as _i751;
import 'package:casttime/features/profile/domain/service/profile_service.dart'
    as _i434;
import 'package:casttime/features/profile/presentation/bloc/profile_bloc.dart'
    as _i930;
import 'package:casttime/features/profile/presentation/cubit/created_locations_cubit.dart'
    as _i582;
import 'package:casttime/features/profile/presentation/cubit/joined_locations_cubit.dart'
    as _i660;
import 'package:casttime/features/profile/presentation/cubit/liked_locations_cubit.dart'
    as _i288;
import 'package:casttime/features/profile/presentation/cubit/location_list_cubit.dart'
    as _i182;
import 'package:casttime/features/setting/data/api/settings_api.dart' as _i871;
import 'package:casttime/features/setting/data/repository/settings_repository_impl.dart'
    as _i226;
import 'package:casttime/features/setting/domain/repository/settings_repository.dart'
    as _i287;
import 'package:casttime/features/setting/presentation/bloc/settings_form_bloc.dart'
    as _i207;
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart'
    as _i101;
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
    gh.lazySingleton<_i337.ProfileSectionCubit>(
      () => _i337.ProfileSectionCubit(),
    );
    gh.lazySingleton<_i994.LoggingInterceptor>(
      () => _i994.LoggingInterceptor(),
    );
    gh.lazySingleton<_i794.LocationBoundsCalculator>(
      () => const _i794.LocationBoundsCalculator(),
    );
    gh.lazySingleton<_i223.SheetSizeMemory>(() => _i223.SheetSizeMemory());
    gh.lazySingleton<_i297.PreferencesRepository>(
      () => _i297.PreferencesRepository(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i993.ApiFailureMapper>(
      () => _i993.ApiFailureMapper(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i455.LocationFailureMapper>(
      () => _i455.LocationFailureMapper(gh<_i974.Logger>()),
    );
    gh.lazySingleton<_i511.TokenStorage>(
      () => _i137.SecureTokenStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i938.AuthInterceptor>(
      () => _i938.AuthInterceptor(gh<_i511.TokenStorage>()),
    );
    gh.lazySingleton<_i418.LocationPermissionService>(
      () =>
          _i977.GeolocatorPermissionService(gh<_i455.LocationFailureMapper>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i938.AuthInterceptor>(),
        gh<_i994.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i507.LocationApi>(
      () => networkModule.provideLocationApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i401.AuthApi>(
      () => networkModule.provideAuthApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i523.ProfileApi>(
      () => networkModule.provideProfileApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i8.PlaceApi>(
      () => networkModule.providePlaceApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i248.InfoApi>(
      () => networkModule.provideInfoApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i871.SettingsApi>(
      () => networkModule.provideSettingsApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i287.SettingsRepository>(
      () => _i226.SettingsRepositoryImpl(
        gh<_i871.SettingsApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i310.LocationRepository>(
      () => _i113.LocationRepositoryImpl(
        gh<_i507.LocationApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i283.LocationService>(
      () => _i449.LocationServiceImpl(
        gh<_i310.LocationRepository>(),
        gh<_i418.LocationPermissionService>(),
        gh<_i455.LocationFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i1030.InfoService>(
      () => _i559.InfoServiceImpl(
        gh<_i248.InfoApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i751.ProfileRepository>(
      () => _i610.ProfileRepositoryImpl(
        gh<_i523.ProfileApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i702.PlaceRepository>(
      () => _i256.PlaceRepositoryImpl(
        gh<_i8.PlaceApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.lazySingleton<_i357.AuthRepository>(
      () => _i17.AuthRepositoryImpl(
        gh<_i401.AuthApi>(),
        gh<_i993.ApiFailureMapper>(),
      ),
    );
    gh.factory<_i981.LocationSearchBloc>(
      () => _i981.LocationSearchBloc(
        gh<_i283.LocationService>(),
        gh<_i794.LocationBoundsCalculator>(),
      ),
    );
    gh.lazySingleton<_i911.PlaceService>(
      () => _i881.PlaceServiceImpl(gh<_i702.PlaceRepository>()),
    );
    gh.factory<_i266.PlaceSuggestionCubit>(
      () => _i266.PlaceSuggestionCubit(gh<_i911.PlaceService>()),
    );
    gh.lazySingleton<_i434.ProfileService>(
      () => _i420.ProfileServiceImpl(
        gh<_i751.ProfileRepository>(),
        gh<_i455.LocationFailureMapper>(),
      ),
    );
    gh.factoryParam<_i582.CreatedLocationsCubit, String, dynamic>(
      (username, _) =>
          _i582.CreatedLocationsCubit(gh<_i434.ProfileService>(), username),
    );
    gh.factoryParam<_i660.JoinedLocationsCubit, String, dynamic>(
      (username, _) =>
          _i660.JoinedLocationsCubit(gh<_i434.ProfileService>(), username),
    );
    gh.factoryParam<_i288.LikedLocationsCubit, String, dynamic>(
      (username, _) =>
          _i288.LikedLocationsCubit(gh<_i434.ProfileService>(), username),
    );
    gh.lazySingleton<_i713.AuthCubit>(
      () =>
          _i713.AuthCubit(gh<_i357.AuthRepository>(), gh<_i511.TokenStorage>()),
    );
    gh.factory<_i930.ProfileBloc>(
      () => _i930.ProfileBloc(gh<_i434.ProfileService>()),
    );
    gh.lazySingleton<_i197.MapBloc>(
      () => _i197.MapBloc(
        gh<_i283.LocationService>(),
        gh<_i418.LocationPermissionService>(),
      ),
    );
    gh.factoryParam<_i182.LocationListCubit, String, _i607.LocationListType>(
      (username, listType) => _i182.LocationListCubit(
        gh<_i434.ProfileService>(),
        username,
        listType,
      ),
    );
    gh.factory<_i144.InfoBloc>(() => _i144.InfoBloc(gh<_i1030.InfoService>()));
    gh.factoryParam<_i312.LocationDetailBloc, _i96.Location, dynamic>(
      (initialLocation, _) => _i312.LocationDetailBloc(
        gh<_i283.LocationService>(),
        initialLocation,
      ),
    );
    gh.lazySingleton<_i101.AppSettingsCubit>(
      () => _i101.AppSettingsCubit(
        gh<_i713.AuthCubit>(),
        gh<_i287.SettingsRepository>(),
        gh<_i297.PreferencesRepository>(),
      ),
    );
    gh.factory<_i207.SettingsFormBloc>(
      () => _i207.SettingsFormBloc(
        gh<_i713.AuthCubit>(),
        gh<_i101.AppSettingsCubit>(),
        gh<_i287.SettingsRepository>(),
        gh<_i297.PreferencesRepository>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i587.StorageModule {}

class _$LoggerModule extends _i186.LoggerModule {}

class _$NetworkModule extends _i585.NetworkModule {}
