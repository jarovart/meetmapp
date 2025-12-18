import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' show LatLngBounds;
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:meetmaap/config/api_config.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';

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
  static final Map<int, LocationFull> _fullLocationCache = {};

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

  static Future<LocationBase> uploadLocation(LocationFull location) async {
    final uploadLocationUrl = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/createLocation',
    );
    debugPrint("Uploading location to ${jsonEncode(location.toMap())}");
    final response = await http.post(
      uploadLocationUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(location.toMap()), // <-- Location als JSON senden
    );
    if (response.statusCode != 200) {
      throw Exception("Server error: ${response.statusCode}");
    }

    final body = jsonDecode(response.body);
    return LocationBase.fromMap(body);
  }

  static Future<List<LocationBase>> fetchAllLocationsInView(
    LatLngBounds bounds,
  ) async {
    final minLat = bounds.southWest.latitude;
    final maxLat = bounds.northEast.latitude;
    final minLng = bounds.southWest.longitude;
    final maxLng = bounds.northEast.longitude;

    final getLocationsForViewUrl = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/within'
      '?minLat=$minLat&maxLat=$maxLat&minLng=$minLng&maxLng=$maxLng',
    );

    final response = await http.get(getLocationsForViewUrl);
    if (response.statusCode != 200) {
      throw Exception("Server error: ${response.statusCode}");
    }

    final body = jsonDecode(response.body) as List;
    return body.map((e) => LocationBase.fromMap(e)).toList();
  }

  static Future<List<LocationBase>> fetchLocationsWithinWithTime(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/locations/withinWithTime')
        .replace(
          queryParameters: {
            'minLat': bounds.southWest.latitude.toString(),
            'maxLat': bounds.northEast.latitude.toString(),
            'minLng': bounds.southWest.longitude.toString(),
            'maxLng': bounds.northEast.longitude.toString(),
            'rangeStart': startDate.toIso8601String(),
            'rangeEnd': endDate.toIso8601String(),
          },
        );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load locations');
    }
    final body = jsonDecode(response.body) as List;
    return body.map((e) => LocationBase.fromMap(e)).toList();
  }

  static Future<LocationFull> fetchFullLocation(int id) async {
    // 🔥 1. Cache-Hit
    if (_fullLocationCache.containsKey(id)) {
      debugPrint('🟢 Location $id aus Cache');
      return _fullLocationCache[id]!;
    }

    // 🔥 2. API-Call
    debugPrint('🔵 Location $id vom Server laden');
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/findById',
    ).replace(queryParameters: {'id': id.toString()});
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load location');
    }
    final location = LocationFull.fromMap(jsonDecode(response.body));

    // 🔥 3. Cache speichern
    _fullLocationCache[id] = location;

    return location;
  }

  /// Optional: Cache invalidieren (z.B. nach Like / Join)
  static void invalidateLocation(int id) {
    _fullLocationCache.remove(id);
  }

  /// Optional: kompletten Cache leeren (Logout)
  static void clearCache() {
    _fullLocationCache.clear();
  }
}
