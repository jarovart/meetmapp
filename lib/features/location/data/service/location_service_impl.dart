import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';

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
  Future<AppResult<LocationDetail>> fetchLocationDetail(int id) async {
    return await repository.fetchFullLocation(id);
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

  @override
  Future<AppResult<void>> like(int locationId) async {
    return await repository.like(locationId);
  }

  @override
  Future<AppResult<void>> unlike(int locationId) async {
    return await repository.unlike(locationId);
  }

  @override
  Future<AppResult<void>> join(int locationId) async {
    return await repository.join(locationId);
  }

  @override
  Future<AppResult<void>> unjoin(int locationId) async {
    return await repository.unjoin(locationId);
  }

  @override
  Future<AppResult<bool>> isLiked(int locationId) async {
    return await repository.isLiked(locationId);
  }

  @override
  Future<AppResult<bool>> isJoined(int locationId) async {
    return await repository.isJoined(locationId);
  }
}
