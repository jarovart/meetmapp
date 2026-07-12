import 'package:casttime/program/core/failure/appfailure.dart';
import 'package:casttime/program/core/appresult.dart';
import 'package:casttime/program/data/repositories/location_repository.dart';
import 'package:casttime/program/domain/models/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@lazySingleton
class LocationService {
  final LocationRepository repository;

  LocationService(this.repository);

  Future<AppResult<List<Location>>> searchLocations(String rawQuery) async {
    final query = rawQuery.trim();

    if (query.length < 2) {
      return Future.value(const Failure(InvalidSearchQueryFailure()));
    }

    return repository.searchLocations(query);
  }

  Future<AppResult<List<Location>>> fetchLocationsInView({
    required LatLngBounds bounds,
  }) async {
    debugPrint("service event: $bounds");
    return repository.fetchLocationsInView(bounds);
  }

  Future<AppResult<Location>> fetchLocation({required int id}) async {
    return Future.value(const Failure(InvalidSearchQueryFailure()));
  }

  Future<LatLng> getCurrentUserPosition() async {
    // geolocator hier oder eigener LocationService
    throw UnimplementedError();
  }
}
