import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/exceptions/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/requests/createlocation_request.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class LocationRepository {
  static final Map<int, LocationFullResponse> _fullLocationCache = {};

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

  static Future<LocationBaseResponse> uploadLocation(
    CreateLocationRequest location,
  ) async {
    final token = await AuthRepository.getToken();

    if (token == null) {
      throw Exception('Not authenticated');
    }
    final uploadLocationUrl = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/createLocation',
    );
    debugPrint("Uploading location to ${jsonEncode(location.toMap())}");
    final response = await http.post(
      uploadLocationUrl,
      headers: {
        'Content-Type': 'application/json',

        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(location.toMap()),
    );
    if (response.statusCode != 201) {
      throw Exception("Server error: ${response.statusCode}");
    }

    final body = jsonDecode(response.body);
    return LocationBaseResponse.fromMap(body);
  }

  //not used
  static Future<List<LocationBaseResponse>> fetchAllLocationsInView(
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
    return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
  }

  static Future<List<LocationBaseResponse>> fetchLocationsWithinWithTime(
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
    return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
  }

  static Future<List<LocationBaseResponse>> searchLocations(
    String query,
  ) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/search?query=$query',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Fehler beim Suchen");
    }

    final body = jsonDecode(response.body) as List;
    return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
  }

  static Future<List<LocationBaseResponse>> fetchLocations() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/api/locations'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception("Fehler beim Suchen");
    }

    final List<dynamic> body = jsonDecode(response.body);
    return body
        .map((e) => LocationBaseResponse.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<LocationFullResponse> fetchFullLocation(int id) async {
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
    final location = LocationFullResponse.fromMap(jsonDecode(response.body));

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

  static Future<String?> reverseGeocodeOSM(double lat, double lon) async {
    final uri = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse'
      '?format=jsonv2'
      '&lat=$lat'
      '&lon=$lon'
      '&addressdetails=1',
    );

    final response = await http.get(
      uri,
      headers: {'User-Agent': 'meetmaap-app/1.0 (contact@meetmaap.app)'},
    );

    if (response.statusCode != 200) return null;
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (data['address'] == null) {
      return data['display_name'] as String?;
    }

    return formatAddress(data['address'] as Map<String, dynamic>);
  }

  static Future<List<LocationBaseResponse>> fetchAllLocationsByFilter(
    String searchText,
    LatLng position,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final uri = Uri.parse('${ApiConfig.baseUrl}/api/locations/allByFilter')
        .replace(
          queryParameters: {
            'lat': position.latitude.toString(),
            'long': position.longitude.toString(),
            'searchText': searchText,
            'rangeStart': startDate.toIso8601String(),
            'rangeEnd': endDate.toIso8601String(),
          },
        );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load locations');
    }
    final body = jsonDecode(response.body) as List;
    return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
  }

  static String formatAddress(Map address) {
    final parts = [
      address['country'],
      address['postcode'],
      address['city'] ?? address['town'] ?? address['village'],
      address['road'],
      address['house_number'],
    ];

    return parts.where((e) => e != null).join(', ');
  }
}
