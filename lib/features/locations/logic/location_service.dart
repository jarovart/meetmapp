import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/// Ergebnis-Typ für Location-Abfragen
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

class LocationService {
  static Future<LocationResult> getCurrentLocation() async {
    try {
      // Service aktiv?
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return const LocationServiceDisabled();

      // Permission prüfen
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const LocationPermissionDenied();
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return const LocationPermissionDenied();
      }

      // Standort holen
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LocationSuccess(LatLng(pos.latitude, pos.longitude));
    } catch (e) {
      return LocationError(e.toString());
    }
  }
}
