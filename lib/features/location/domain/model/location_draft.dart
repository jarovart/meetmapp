import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location_draft.freezed.dart';

@freezed
abstract class LocationDraft with _$LocationDraft {
  const factory LocationDraft({
    required String title,
    required String description,
    required String address,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required LatLng position,
    required String createdUsername,
  }) = _LocationDraft;
}
