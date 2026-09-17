// features/location/domain/model/location_filter.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location_filter.freezed.dart';

@freezed
abstract class LocationFilter with _$LocationFilter {
  const factory LocationFilter({
    DateTime? start,
    DateTime? end,
    LatLng? center,
    String? placeText,
    @Default(10.0) double radiusKm,
  }) = _LocationFilter;
}
