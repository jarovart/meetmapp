import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';

class LocationState {
  final Location? location;
  final LoadStatus status;
  final AppFailure? failure;

  const LocationState({
    required this.location,
    this.status = LoadStatus.initial,
    this.failure,
  });

  factory LocationState.initial(Location location) {
    return LocationState(location: location);
  }

  LocationState copyWith({
    Location? location,
    LoadStatus? status,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return LocationState(
      location: location ?? this.location,
      status: status ?? this.status,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  List<String> get imageUrls {
    final images = location?.images;
    if (images != null && images.isNotEmpty) {
      return images.map((img) => img.imageUrl).toList();
    }
    return [];
  }
}
