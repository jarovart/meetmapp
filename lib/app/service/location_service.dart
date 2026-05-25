import 'dart:typed_data';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/request/createlocation_request.dart';
import 'package:meetmaap/app/model/exception/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/request/editmylocation_request.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/model/response/slicelist_response.dart';
import 'package:meetmaap/app/repository/location_repository.dart';

/// Ergebnis-Typ für Location-Abfragen
class LocationService {
  static Future<LocationResult> getCurrentLocation() async {
    return await LocationRepository.getCurrentLocation();
  }

  static Future<LocationBaseResponse> uploadLocation(
    CreateLocationRequest createdLocation,
  ) async {
    return await LocationRepository.uploadLocation(createdLocation);
  }

  static Future<List<LocationBaseResponse>> fetchLocationsWithinWithTime(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await LocationRepository.fetchLocationsWithinWithTime(
      bounds,
      startDate,
      endDate,
    );
  }

  static Future searchLocations(String text) async {
    return await LocationRepository.searchLocations(text);
  }

  static Future<List<LocationBaseResponse>> fetchLocations() async {
    return await LocationRepository.fetchLocations();
  }

  static Future<LocationFullResponse>? fetchFullLocation(int id) async {
    return await LocationRepository.fetchFullLocation(id);
  }

  static Future<SliceResponse<LocationBaseResponse>>
  fetchLocationsByFilterSettings(
    String searchText,
    LatLng position,
    double radiusKm,
    DateTime startDateTime,
    DateTime endDateTime, {
    required int page,
    required int pageSize,
  }) async {
    //return await LocationRepository.fetchLocations();
    return await LocationRepository.fetchAllLocationsByFilter(
      searchText,
      position,
      radiusKm,
      startDateTime,
      endDateTime,
      page: page,
      pageSize: pageSize,
    );
  }

  static Future<String?> reverseGeocodeOSM(
    double latitude,
    double longitude,
  ) async {
    final dataMap = await LocationRepository.reverseGeocodeOSM(
      latitude,
      longitude,
    );
    if (dataMap['address'] == null) {
      return dataMap['display_name'] as String?;
    }

    return _formatAddress(dataMap['address']);
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

  static Future<List<LocationBaseResponse>> getJoinedLocationsByUserId(
    int userId,
  ) async {
    return await LocationRepository.fetchJoinedLocationsByUserId(userId);
  }

  static Future<List<LocationBaseResponse>> getCreatedLocationsByUserId(
    int userId,
  ) async {
    return await LocationRepository.fetchCreatedLocationsByUserId(userId);
  }

  static Future<List<LocationBaseResponse>> getLikedLocationsByUserId(
    int userId,
  ) async {
    return await LocationRepository.fetchLikedLocationsByUserId(userId);
  }

  static Future<void> like(int locationId) async {
    await LocationRepository.like(locationId);
  }

  static Future<void> unlike(int locationId) async {
    await LocationRepository.unlike(locationId);
  }

  static Future<void> join(int locationId) async {
    await LocationRepository.join(locationId);
  }

  static Future<void> unjoin(int locationId) async {
    await LocationRepository.unjoin(locationId);
  }

  static Future<bool> isLiked(int locationId) async {
    return await LocationRepository.isLiked(locationId);
  }

  static Future<bool> isJoined(int locationId) async {
    return await LocationRepository.isJoined(locationId);
  }

  static String _formatAddress(Map address) {
    final parts = [
      address['country'],
      address['postcode'],
      address['city'] ?? address['town'] ?? address['village'],
      address['road'],
      address['house_number'],
    ];

    return parts.where((e) => e != null).join(', ');
  }

  static Future<LocationFullResponse> updateMyLocation(
    EditMyLocationRequest editMyLocationRequest,
    List<Uint8List> newImages,
  ) async {
    if (newImages.isNotEmpty) {
      //await delete old images?
    }
    final locationFull = await LocationRepository.updateMyLocation(
      editMyLocationRequest,
    );
    return locationFull;
  }
}
