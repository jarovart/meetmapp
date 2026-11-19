import 'package:casttime/features/image/domain/model/image_entry.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location_update.freezed.dart';

@freezed
abstract class LocationUpdate with _$LocationUpdate {
  const factory LocationUpdate({
    required int id,
    required String title,
    required String description,
    required String address,
    required LatLng position,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required List<ImageEntry> images,
  }) = _LocationUpdate;
}
