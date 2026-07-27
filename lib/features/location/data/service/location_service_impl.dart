import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  final LocationRepository repository;

  LocationServiceImpl(this.repository);

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

  Future<AppResult<LatLng>> getCurrentUserPosition() async {
    // geolocator hier oder eigener LocationService
    throw UnimplementedError();
  }
}
