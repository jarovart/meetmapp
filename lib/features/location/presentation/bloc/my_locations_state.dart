import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_locations_state.freezed.dart';

@freezed
abstract class MyLocationsState with _$MyLocationsState {
  const factory MyLocationsState({
    @Default(LoadStatus.initial) LoadStatus status,
    @Default([]) List<Location> locations,
    @Default(0) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(<int>{}) Set<int> pendingRemovalIds,
    AppFailure? failure,
  }) = _MyLocationsState;

  const MyLocationsState._();

  /// true, sobald etwas verlassen wurde und noch angezeigt wird.
  bool get isDirty => pendingRemovalIds.isNotEmpty;
}
