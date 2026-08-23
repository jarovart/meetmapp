import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

abstract interface class LocationService {
  Future<AppResult<List<Location>>> searchLocations(String rawQuery);
  Future<AppResult<List<Location>>> fetchLocationsInView({
    required LatLngBounds bounds,
  });
  Future<AppResult<Location>> fetchLocation({required int id});
  Future<AppResult<List<Location>>> fetchLocationsWithDateRange(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  );
}
