import 'package:flutter_map/flutter_map.dart';
import 'package:meetmaap/app/model/createlocation_request.dart';
import 'package:meetmaap/app/model/exceptions/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/location_base.dart';
import 'package:meetmaap/app/model/location_full.dart';
import 'package:meetmaap/app/repository/location_repository.dart';

/// Ergebnis-Typ für Location-Abfragen
class LocationService {
  static Future<LocationResult> getCurrentLocation() async {
    return LocationRepository.getCurrentLocation();
  }

  static Future<LocationBase> uploadLocation(
    CreateLocationRequest createdLocation,
  ) async {
    return LocationRepository.uploadLocation(createdLocation);
  }

  static Future<List<LocationBase>> fetchLocationsWithinWithTime(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return LocationRepository.fetchLocationsWithinWithTime(
      bounds,
      startDate,
      endDate,
    );
  }

  static Future searchLocations(String text) async {
    return LocationRepository.searchLocations(text);
  }

  static Future<LocationFull>? fetchFullLocation(int id) async {
    return LocationRepository.fetchFullLocation(id);
  }

  static Future<String?> reverseGeocodeOSM(double latitude, double longitude) {
    return LocationRepository.reverseGeocodeOSM(latitude, longitude);
  }
}
