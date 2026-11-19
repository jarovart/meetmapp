import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/image/domain/model/image_entry.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location_edit_state.freezed.dart';

@freezed
abstract class LocationEditState with _$LocationEditState {
  const factory LocationEditState({
    Location? original,
    @Default(LoadStatus.initial) LoadStatus status,
    @Default('') String title,
    @Default('') String description,
    @Default('') String address,
    LatLng? position,
    DateTime? startDateTime,
    DateTime? endDateTime,
    @Default([]) List<ImageEntry> images,
    @Default(false) bool isProcessingImage,
    @Default(false) bool isSaving,
    @Default(false) bool isSaved,
    AppFailure? failure,
  }) = _LocationEditState;

  const LocationEditState._();

  bool get isBusy => isSaving || isProcessingImage;
}
