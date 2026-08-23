import 'dart:async';

import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/failure/geolocation_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/map/domain/service/location_permission_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@LazySingleton(as: LocationPermissionService)
class GeolocatorPermissionService implements LocationPermissionService {
  const GeolocatorPermissionService(this.failureMapper);

  final LocationFailureMapper failureMapper;

  @override
  Future<AppResult<LocationPermission>> requestPermission() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw const LocationServiceDisabledException();

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw const PermissionDeniedException("todo message");
      }
      if (permission == LocationPermission.deniedForever) {
        return const Failure(LocationPermissionDeniedForeverFailure());
      }

      return Success(permission);
    } catch (e, st) {
      return Failure(failureMapper.map(e, st));
    }
  }

  @override
  Future<AppResult<LatLng>> getCurrentPosition() async {
    //TODO repo klasse
    try {
      final position =
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw TimeoutException('Location request timed out todo'),
          );
      return Success(LatLng(position.latitude, position.longitude));
    } catch (e, st) {
      return Failure(failureMapper.map(e, st));
    }
  }
}
