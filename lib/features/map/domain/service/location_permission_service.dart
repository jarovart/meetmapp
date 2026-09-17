import 'package:casttime/core/result/app_result.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationPermissionService {
  Future<AppResult<LocationPermission>> requestPermission();
}
