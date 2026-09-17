import 'dart:async';

import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/failure/geolocation_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/map/domain/service/location_permission_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationPermissionService)
class GeolocatorPermissionService implements LocationPermissionService {
  const GeolocatorPermissionService(this.failureMapper);

  final LocationFailureMapper failureMapper;

  @override
  Future<AppResult<LocationPermission>> requestPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return const Failure(LocationServiceDisabledFailure());

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      return const Failure(LocationPermissionDeniedFailure());
    }
    if (permission == LocationPermission.deniedForever) {
      return const Failure(LocationPermissionDeniedForeverFailure());
    }

    return Success(permission);
  }
}
