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

  @override
  Future<AppResult<List<Location>>> searchLocations(String rawQuery) async {
    final query = rawQuery.trim();

    if (query.length < 3) {
      return Future.value(const Failure(InvalidSearchQueryFailure()));
    }

    return repository.searchLocations(query);
  }

  @override
  Future<AppResult<List<Location>>> fetchLocationsInView({
    required LatLngBounds bounds,
  }) async {
    debugPrint("service event: $bounds");
    return repository.fetchLocationsInView(bounds);
  }

  @override
  Future<AppResult<Location>> fetchLocation({required int id}) async {
    return Future.value(const Failure(InvalidSearchQueryFailure()));
  }

  @override
  Future<AppResult<List<Location>>> fetchLocationsWithDateRange(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (startDate.compareTo(endDate) > 0) {
      return Future.value(const Failure(InvalidDateRangeFailure()));
    }

    return repository.fetchLocationsWithDateRange(bounds, startDate, endDate);
  }
}
