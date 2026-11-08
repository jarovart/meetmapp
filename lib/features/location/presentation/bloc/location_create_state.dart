import 'dart:typed_data';

import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location_create_state.freezed.dart';

enum CreateStep {
  idle(null),
  savingLocation('savingLocation'),
  uploadingImages('uploadingImages'),
  settingThumbnail('settingThumbnail'),
  updatePosition('updatePosition'),
  done(null);

  const CreateStep(this.messageKey);
  final String? messageKey;
}

@freezed
abstract class LocationCreateState with _$LocationCreateState {
  const factory LocationCreateState({
    LatLng? initialPosition,
    LatLng? position,
    String? initialAddress,
    @Default('') String title,
    @Default('') String description,
    @Default('') String address,
    DateTime? startDateTime,
    DateTime? endDateTime,
    @Default([]) List<Uint8List> images,
    @Default(false) bool isProcessingImage,
    @Default(CreateStep.idle) CreateStep step,
    Location? createdLocation,
    AppFailure? failure,
  }) = _LocationCreateState;

  const LocationCreateState._();

  bool get isBusy => step != CreateStep.idle && step != CreateStep.done;
}
