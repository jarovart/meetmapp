import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';

class LocationDetailState {
  final Location location;
  final LocationDetail? locationDetail;
  final LoadStatus status;
  final AppFailure? failure;

  const LocationDetailState({
    required this.location,
    this.locationDetail,
    this.status = LoadStatus.initial,
    this.failure,
  });

  factory LocationDetailState.initial(Location location) {
    return LocationDetailState(location: location);
  }

  LocationDetailState copyWith({
    Location? location,
    LocationDetail? locationDetail,
    LoadStatus? status,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return LocationDetailState(
      location: location ?? this.location,
      locationDetail: locationDetail ?? this.locationDetail,
      status: status ?? this.status,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
