import 'package:casttime/core/result/app_result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

abstract class LocationPermissionService {
  Future<AppResult<LocationPermission>> requestPermission();
  Future<AppResult<LatLng>> getCurrentPosition();
}
