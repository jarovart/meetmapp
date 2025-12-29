import 'package:latlong2/latlong.dart';

sealed class LocationResult {
  const LocationResult();
}

class LocationSuccess extends LocationResult {
  final LatLng position;
  const LocationSuccess(this.position);
}

class LocationPermissionDenied extends LocationResult {
  const LocationPermissionDenied();
}

class LocationServiceDisabled extends LocationResult {
  const LocationServiceDisabled();
}

class LocationError extends LocationResult {
  final String message;
  const LocationError(this.message);
}
