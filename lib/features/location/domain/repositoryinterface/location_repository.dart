import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter_map/flutter_map.dart';

abstract interface class LocationRepository {
  Future<AppResult<List<Location>>> fetchLocationsInView(LatLngBounds bounds);

  Future<AppResult<List<Location>>> searchLocations(String query);

  Future<AppResult<Location>> createLocation(Location location);

  Future<AppResult<List<Location>>> fetchLocationsWithDateRange(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  );
}

class CreateLocationCommand {}
