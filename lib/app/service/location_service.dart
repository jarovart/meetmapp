import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/requests/createlocation_request.dart';
import 'package:meetmaap/app/model/exceptions/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/repository/location_repository.dart';

/// Ergebnis-Typ für Location-Abfragen
class LocationService {
  static Future<LocationResult> getCurrentLocation() async {
    return LocationRepository.getCurrentLocation();
  }

  static Future<LocationBaseResponse> uploadLocation(
    CreateLocationRequest createdLocation,
  ) async {
    return LocationRepository.uploadLocation(createdLocation);
  }

  static Future<List<LocationBaseResponse>> fetchLocationsWithinWithTime(
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

  static Future<List<LocationBaseResponse>> fetchLocations() async {
    return LocationRepository.fetchLocations();
  }

  static Future<LocationFullResponse>? fetchFullLocation(int id) async {
    return LocationRepository.fetchFullLocation(id);
  }

  static Future<List<LocationBaseResponse>> fetchLocationsByFilterSettings(
    String searchText,
    LatLng position,
    double radiusKm,
    DateTime startDateTime,
    DateTime endDateTime,
  ) async {
    return LocationRepository.fetchLocations();
    /* TODO: API call fix
    return LocationRepository.fetchAllLocationsByFilter(
      searchText,
      position,
      radiusKm,
      startDateTime,
      endDateTime,
    );*/
  }

  static Future<String?> reverseGeocodeOSM(double latitude, double longitude) {
    return LocationRepository.reverseGeocodeOSM(latitude, longitude);
  }

  static int getLocationScore({
    required int likedUserCount,
    required int joinedUserCount,
    required DateTime startDateTime,
    required DateTime endDateTime,
    DateTime? now,
  }) {
    final n = now ?? DateTime.now();

    var score = likedUserCount * 3 + joinedUserCount;

    // Bonus: Event läuft gerade
    if (startDateTime.isBefore(n) && endDateTime.isAfter(n)) {
      score += 5;
    }

    // Bonus: Startet bald (< 24h) – optional: nur wenn noch nicht gestartet
    final hoursToStart = startDateTime.difference(n).inHours;
    if (hoursToStart >= 0 && hoursToStart < 24) {
      score += 2;
    }

    return score;
  }
}
