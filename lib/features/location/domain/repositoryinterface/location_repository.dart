import 'dart:typed_data';

import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/image/domain/model/app_image.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_draft.dart';
import 'package:casttime/features/location/domain/model/location_update.dart';
import 'package:flutter_map/flutter_map.dart';

abstract interface class LocationRepository {
  Future<AppResult<List<Location>>> fetchLocationsInView(LatLngBounds bounds);

  Future<AppResult<List<Location>>> searchLocations(String query);

  Future<AppResult<List<Location>>> fetchLocationsWithDateRange(
    LatLngBounds bounds,
    DateTime startDate,
    DateTime endDate,
  );

  Future<AppResult<Location>> fetchFullLocation(int id);

  Future<AppResult<void>> like(int locationId);

  Future<AppResult<void>> unlike(int locationId);

  Future<AppResult<void>> join(int locationId);

  Future<AppResult<void>> unjoin(int locationId);

  Future<AppResult<bool>> isLiked(int locationId);

  Future<AppResult<bool>> isJoined(int locationId);

  Future<AppResult<PagedResult<Location>>> searchLocationsWithFilter({
    String? query,
    required LatLngBounds bounds,
    required DateTime start,
    required DateTime end,
    required int page,
    required int pageSize,
  });

  Future<AppResult<Location>> createLocation(LocationDraft draft);
  Future<AppResult<List<AppImage>>> uploadImages(
    List<Uint8List> images,
    int locationId,
  );
  Future<AppResult<Location>> setThumbnail(int locationId, int imageId);

  Future<AppResult<Location>> updateLocation(LocationUpdate update);
}

class CreateLocationCommand {}
