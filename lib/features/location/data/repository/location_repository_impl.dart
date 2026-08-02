import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/data/api/locationapi.dart';
import 'package:casttime/features/location/data/mapper/location_mapper.dart';
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
  Future<AppResult<List<Location>>> searchLocations(String query) {
    return _execute(
      request: () => _api.searchLocations(query),
      map: (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
    );
  }

  @override
  Future<AppResult<Location>> createLocation(Location location) {
    return _execute(
      request: () => _api.createLocation(location.fromDomain()),
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

  Future<AppResult<Domain>> _execute<Dto, Domain>({
    required Future<Dto> Function() request,
    required Domain Function(Dto dto) map,
  }) async {
    try {
      final dto = await request();
      return Success(map(dto));
    } catch (error, stackTrace) {
      debugPrint("repository error: $error");
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
