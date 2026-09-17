// features/place/domain/model/place.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'place.freezed.dart';

@freezed
abstract class Place with _$Place {
  const factory Place({
    required String name,
    required LatLng position,
    required bool existedPlace,
  }) = _Place;
}
