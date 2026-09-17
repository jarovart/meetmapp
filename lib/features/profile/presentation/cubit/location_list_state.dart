// features/profile/presentation/cubit/location_list_state.dart
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_list_state.freezed.dart';

@freezed
abstract class LocationListState with _$LocationListState {
  const factory LocationListState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default([]) List<Location> locations,
    @Default(0) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    AppFailure? failure,
  }) = _LocationListState;
}
