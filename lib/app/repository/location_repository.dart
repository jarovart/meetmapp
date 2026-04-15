import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/config/api_config.dart';
import 'package:meetmaap/app/model/enums/locationtype_enum.dart';
import 'package:meetmaap/app/model/exception/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/request/createlocation_request.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/model/response/slicelist_response.dart';
import 'package:meetmaap/app/model/util/api_exception_wrapper.dart';
import 'package:meetmaap/app/repository/util/api_response_handler.dart';
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
    return ApiExceptionWrapper.guard(() async {
      final uploadLocationUrl = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/createLocation',
      );

      debugPrint("Uploading location to ${jsonEncode(location.toMap())}");
      final headers = await AuthRepository.authHeaders();
      final response = await http.post(
        uploadLocationUrl,
        headers: headers,
        body: jsonEncode(location.toMap()),
      );

      final body = ApiResponseHandler.parseJsonObject(response);
      return LocationBaseResponse.fromMap(body);
    });
  }

  //not used
  static Future<List<LocationBaseResponse>> fetchAllLocationsInView(
    LatLngBounds bounds,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final minLat = bounds.southWest.latitude;
      final maxLat = bounds.northEast.latitude;
      final minLng = bounds.southWest.longitude;
      final maxLng = bounds.northEast.longitude;

      final getLocationsForViewUrl = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/within'
        '?minLat=$minLat&maxLat=$maxLat&minLng=$minLng&maxLng=$maxLng',
      );
      final response = await http.get(getLocationsForViewUrl);

      final body = ApiResponseHandler.parseJsonList(response);
      return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
    });
  }

  static Future<List<LocationBaseResponse>> fetchLocationsWithinWithTime(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return ApiExceptionWrapper.guard(() async {
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

      final body = ApiResponseHandler.parseJsonList(response);
      return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
    });
  }

  static Future<List<LocationBaseResponse>> searchLocations(
    String query,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/search?query=$query',
      );
      final response = await http.get(url);

      final body = ApiResponseHandler.parseJsonList(response);
      return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
    });
  }

  static Future<List<LocationBaseResponse>> fetchLocations() async {
    return ApiExceptionWrapper.guard(() async {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/api/locations'),
        headers: {'Content-Type': 'application/json'},
      );

      final List<dynamic> body = ApiResponseHandler.parseJsonList(response);
      return body
          .map((e) => LocationBaseResponse.fromMap(e as Map<String, dynamic>))
          .toList();
    });
  }

  static Future<LocationFullResponse> fetchFullLocation(int id) async {
    return ApiExceptionWrapper.guard(() async {
      // 🔥 1. Cache-Hit
      /*if (_fullLocationCache.containsKey(id)) {
      debugPrint('🟢 Location $id aus Cache');
      return _fullLocationCache[id]!;
    }*/

      // 🔥 2. API-Call
      debugPrint('🔵 Location $id vom Server laden');
      final url = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/findById',
      ).replace(queryParameters: {'id': id.toString()});
      final headers = await AuthRepository.authHeaders();
      final response = await http.get(url, headers: headers);

      final body = ApiResponseHandler.parseJsonObject(response);
      final location = LocationFullResponse.fromMap(body);
      debugPrint(location.toMap().toString());
      // 🔥 3. Cache speichern
      _fullLocationCache[id] = location;

      return location;
    });
  }

  /// Optional: Cache invalidieren (z.B. nach Like / Join)
  static void _invalidateLocation(int id) {
    _fullLocationCache.remove(id);
  }

  /// Optional: kompletten Cache leeren (Logout)
  static void _clearCache() {
    _fullLocationCache.clear();
  }

  static Future<Map<String, dynamic>> reverseGeocodeOSM(
    double lat,
    double lon,
  ) async {
    return ApiExceptionWrapper.guard(() async {
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

      return ApiResponseHandler.parseJsonObject(response);
    });
  }

  static Future<SliceResponse<LocationBaseResponse>> fetchAllLocationsByFilter(
    String searchText,
    LatLng position,
    double radiusKm,
    DateTime startDate,
    DateTime endDate, {
    required int page,
    required int pageSize,
  }) async {
    return ApiExceptionWrapper.guard(() async {
      final headers = await AuthRepository.authHeaders();
      final uri = Uri.parse('${ApiConfig.baseUrl}/api/locations/findByFilter')
          .replace(
            queryParameters: {
              'query': searchText,
              'lat': position.latitude.toString(),
              'lng': position.longitude.toString(),
              'radiusKm': radiusKm.toString(),
              'rangeStart': startDate.toIso8601String(),
              'rangeEnd': endDate.toIso8601String(),
              'page': page.toString(),
              'size': pageSize.toString(),
            },
          );

      final response = await http.get(uri, headers: headers);

      final decoded = ApiResponseHandler.parseJsonMap(response);
      return SliceResponse.fromMap(
        decoded,
        (item) => LocationBaseResponse.fromMap(item),
      );
    });
  }

  static Future<List<LocationBaseResponse>> fetchJoinedLocationsByUserId(
    int userId,
  ) async {
    return _fetchLocationsByUserId(userId, LocationType.joined);
  }

  static Future<List<LocationBaseResponse>> fetchCreatedLocationsByUserId(
    int userId,
  ) async {
    return _fetchLocationsByUserId(userId, LocationType.created);
  }

  static Future<List<LocationBaseResponse>> fetchLikedLocationsByUserId(
    int userId,
  ) async {
    return _fetchLocationsByUserId(userId, LocationType.liked);
  }

  static Future<void> like(int locationId) {
    return _performLocationAction(locationId, "like", true);
  }

  static Future<void> unlike(int locationId) {
    return _performLocationAction(locationId, "like", false);
  }

  static Future<void> join(int locationId) {
    return _performLocationAction(locationId, "join", true);
  }

  static Future<void> unjoin(int locationId) {
    return _performLocationAction(locationId, "join", false);
  }

  static Future<bool> isLiked(int locationId) {
    return _checkUserLocationAction(locationId, "like");
  }

  static Future<bool> isJoined(int locationId) {
    return _checkUserLocationAction(locationId, "join");
  }

  static Future<List<LocationBaseResponse>> _fetchLocationsByUserId(
    int userId,
    LocationType locationType,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/users/$userId/locations/${locationType.path}',
      );

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      final body = ApiResponseHandler.parseJsonList(response);
      return body.map((e) => LocationBaseResponse.fromMap(e)).toList();
    });
  }

  static Future<void> _performLocationAction(
    int locationId,
    String action,
    bool toPost,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/$locationId/$action',
      );

      final headers = await AuthRepository.authHeaders();
      final response = toPost
          ? await http.post(uri, headers: headers)
          : await http.delete(uri, headers: headers);

      ApiResponseHandler.ensureSuccess(response);
    });
  }

  static Future<bool> _checkUserLocationAction(
    int locationId,
    String action,
  ) async {
    return ApiExceptionWrapper.guard(() async {
      final uri = Uri.parse(
        '${ApiConfig.baseUrl}/api/locations/$locationId/$action',
      );

      final headers = await AuthRepository.authHeaders();
      final response = await http.get(uri, headers: headers);

      ApiResponseHandler.ensureSuccess(response);
      return true;
    });
  }
}
