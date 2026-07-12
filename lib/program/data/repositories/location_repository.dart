import 'package:casttime/program/core/appresult.dart';
import 'package:casttime/program/domain/models/location.dart';
import 'package:flutter_map/flutter_map.dart';

abstract interface class LocationRepository {
  Future<AppResult<List<Location>>> fetchLocationsInView(LatLngBounds bounds);

  Future<AppResult<List<Location>>> searchLocations(String query);

  Future<AppResult<Location>> createLocation(Location location);
}

class CreateLocationCommand {}
