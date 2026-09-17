import 'dart:async';

import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/failure/geolocation_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/map/domain/service/location_permission_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@LazySingleton(as: LocationService)
class LocationServiceImpl implements LocationService {
  final LocationRepository repository;
  final LocationPermissionService _permissionService;
  final LocationFailureMapper failureMapper;

  LocationServiceImpl(
    this.repository,
    this._permissionService,
    this.failureMapper,
  );

  // data/service/location_service_impl.dart
  @override
  Stream<LatLng> watchCurrentPosition() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // erst ab 10m Bewegung ein neues Event
      ),
    ).map((p) => LatLng(p.latitude, p.longitude));
  }

  @override
  Future<AppResult<LatLng>> getCurrentPosition() async {
    final permissionResult = await _permissionService.requestPermission();
    if (permissionResult case Failure(:final failure)) {
      return Failure(failure);
    }

    try {
      final position =
          await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
            ),
          ).timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw TimeoutException('Location request timed out todo'),
          );
      return Success(LatLng(position.latitude, position.longitude));
    } catch (e, st) {
      return Failure(failureMapper.map(e, st));
    }
  }

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

  @override
  Future<AppResult<PagedResult<Location>>> searchLocationsWithFilter({
    String? query,
    required LatLngBounds bounds,
    required DateTime start,
    required DateTime end,
    required int page,
    int pageSize = 10,
  }) async {
    return await repository.searchLocationsWithFilter(
      query: query,
      bounds: bounds,
      start: start,
      end: end,
      page: page,
      pageSize: pageSize,
    );
  }
}
