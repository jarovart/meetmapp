import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/model/location_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'locationlist_state.freezed.dart';

@freezed
abstract class LocationSearchState with _$LocationSearchState {
  const factory LocationSearchState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default('') String query,
    @Default([]) List<Location> locations,
    @Default(0) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    LatLng? currentPosition,
    LocationFilter? filter,
    AppFailure? failure,
  }) = _LocationSearchState;
}
