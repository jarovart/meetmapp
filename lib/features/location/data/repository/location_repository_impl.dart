import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/data/api/location_api.dart';
import 'package:casttime/features/location/data/mapper/location_detail_dto_mapper.dart';
import 'package:casttime/features/location/data/mapper/location_dto_mapper.dart';
import 'package:casttime/features/location/data/mapper/location_request_mapper.dart';
import 'package:casttime/features/location/data/mapper/location_slice_dto_mapper.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';
import 'package:casttime/features/location/domain/repositoryinterface/location_repository.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  const LocationRepositoryImpl(this._api, this._failureMapper);

  final LocationApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<List<Location>>> fetchLocationsInView(LatLngBounds bounds) {
    final minLat = bounds.southWest.latitude;
    final maxLat = bounds.northEast.latitude;
    final minLng = bounds.southWest.longitude;
    final maxLng = bounds.northEast.longitude;

    debugPrint("repository event: $bounds");

    return _execute(
      request: () => _api.fetchLocationsInView(minLat, maxLat, minLng, maxLng),
      map: (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
    );
  }

  @override
  Future<AppResult<LocationDetail>> fetchFullLocation(int id) {
    return _execute(
      request: () => _api.fetchFullLocation(id),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<List<Location>>> searchLocations(String query) {
    return _execute(
      request: () => _api.searchLocations(query),
      map: (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
    );
  }

  @override
  Future<AppResult<Location>> createLocation(LocationDetail location) {
    return _execute(
      request: () => _api.createLocation(location.toCreateRequest()),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<List<Location>>> fetchLocationsWithDateRange(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final minLat = bounds.southWest.latitude;
    final maxLat = bounds.northEast.latitude;
    final minLng = bounds.southWest.longitude;
    final maxLng = bounds.northEast.longitude;

    return _execute(
      request: () => _api.fetchLocationsWithDateRange(
        minLat,
        maxLat,
        minLng,
        maxLng,
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      ),
      map: (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
    );
  }

  @override
  Future<AppResult<void>> join(int locationId) {
    return _execute(request: () => _api.join(locationId), map: (_) => {});
  }

  @override
  Future<AppResult<void>> like(int locationId) {
    return _execute(request: () => _api.like(locationId), map: (_) => {});
  }

  @override
  Future<AppResult<void>> unjoin(int locationId) {
    return _execute(request: () => _api.unjoin(locationId), map: (_) => {});
  }

  @override
  Future<AppResult<void>> unlike(int locationId) {
    return _execute(request: () => _api.unlike(locationId), map: (_) => {});
  }

  @override
  Future<AppResult<bool>> isJoined(int locationId) {
    return _execute(
      request: () => _api.isJoined(locationId),
      map: (dto) => dto,
    );
  }

  @override
  Future<AppResult<bool>> isLiked(int locationId) {
    return _execute(request: () => _api.isLiked(locationId), map: (dto) => dto);
  }

  @override
  Future<AppResult<PagedResult<Location>>> searchLocationsWithFilter({
    String? query,
    required LatLngBounds bounds,
    required DateTime start,
    required DateTime end,
    required int page,
    required int pageSize,
  }) {
    return _execute(
      request: () => _api.searchLocationsWithFilter(
        query: query,
        minLat: bounds.southWest.latitude,
        maxLat: bounds.northEast.latitude,
        minLng: bounds.southWest.longitude,
        maxLng: bounds.northEast.longitude,
        rangeStart: start.toIso8601String(),
        rangeEnd: end.toIso8601String(),
        page: page,
        pageSize: pageSize,
      ),
      map: (dto) => dto.toDomain(),
    );
  }

  Future<AppResult<Domain>> _execute<Dto, Domain>({
    required Future<Dto> Function() request,
    required Domain Function(Dto dto) map,
  }) async {
    try {
      final dto = await request();
      return Success(map(dto));
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
