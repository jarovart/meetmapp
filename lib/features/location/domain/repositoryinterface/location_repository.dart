import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';
import 'package:flutter_map/flutter_map.dart';

abstract interface class LocationRepository {
  Future<AppResult<List<Location>>> fetchLocationsInView(LatLngBounds bounds);

  Future<AppResult<List<Location>>> searchLocations(String query);

  Future<AppResult<Location>> createLocation(LocationDetail location);

  Future<AppResult<List<Location>>> fetchLocationsWithDateRange(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  );

  Future<AppResult<LocationDetail>> fetchFullLocation(int id);

  Future<AppResult<void>> like(int locationId);

  Future<AppResult<void>> unlike(int locationId);

  Future<AppResult<void>> join(int locationId);

  Future<AppResult<void>> unjoin(int locationId);

  Future<AppResult<bool>> isLiked(int locationId);

  Future<AppResult<bool>> isJoined(int locationId);
}

class CreateLocationCommand {}
