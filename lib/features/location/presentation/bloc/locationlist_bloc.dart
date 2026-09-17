import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/result/paged_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/location/domain/util/location_bounds_calculator.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_event.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_state.dart';
import 'package:casttime/features/map/presentation/util/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@injectable
class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  LocationSearchBloc(this._locationService, this._boundsCalculator)
    : super(const LocationSearchState()) {
    on<LocationSearchStarted>(_onStarted);
    on<LocationSearchQueryChanged>(_onQueryChanged);
    on<LocationSearchSubmitted>(_onSubmitted);
    on<LocationSearchLoadMoreRequested>(_onLoadMoreRequested);
    on<LocationSearchFilterApplied>(_onFilterApplied);
    on<LocationSearchCleared>(_onCleared);
  }

  final LocationService _locationService;
  final LocationBoundsCalculator _boundsCalculator;
  final Debouncer _searchDebouncer = Debouncer(
    delay: const Duration(milliseconds: 700),
  );
  static const _defaultRadiusKm = 10.0;

  Future<void> _onStarted(
    LocationSearchStarted event,
    Emitter<LocationSearchState> emit,
  ) async {
    final result = await _locationService.getCurrentPosition();
    switch (result) {
      case Success<LatLng>(:final data):
        emit(state.copyWith(currentPosition: data));
      case Failure<LatLng>(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }

  Future<void> _onQueryChanged(
    LocationSearchQueryChanged event,
    Emitter<LocationSearchState> emit,
  ) async {
    emit(state.copyWith(query: event.query));
    if (event.query.trim().length < 3) {
      _searchDebouncer.cancel();
      return;
    }
    _searchDebouncer.run(() => add(LocationSearchSubmitted()));
  }

  Future<void> _onSubmitted(
    LocationSearchSubmitted event,
    Emitter<LocationSearchState> emit,
  ) async {
    if (state.query.trim().length < 3) return;
    await _search(emit);
  }

  Future<void> _onFilterApplied(
    LocationSearchFilterApplied event,
    Emitter<LocationSearchState> emit,
  ) async {
    emit(state.copyWith(filter: event.filter));
    if (state.query.trim().length < 3) return;
    await _search(emit);
  }

  Future<void> _onCleared(
    LocationSearchCleared event,
    Emitter<LocationSearchState> emit,
  ) async {
    emit(state.copyWith(query: '', locations: [], status: LoadStatus.initial));
  }

  Future<void> _search(Emitter<LocationSearchState> emit) async {
    final center = state.filter?.center ?? state.currentPosition;
    if (center == null) {
      emit(
        state.copyWith(
          status: LoadStatus.failure,
          failure: NoLocationAvailable(),
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoadStatus.loading));

    final bounds = _boundsCalculator.fromCenter(
      center: center,
      boxSizeKm: state.filter?.radiusKm ?? _defaultRadiusKm,
    );

    final result = await _locationService.searchLocationsWithFilter(
      query: state.query.trim(),
      bounds: bounds,
      start: state.filter?.start ?? DateTime.now(),
      end: state.filter?.end ?? DateTime.now().add(const Duration(days: 1)),
      page: 0,
    );

    switch (result) {
      case Success<PagedResult<Location>>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            locations: data.items,
            page: 0,
            hasMore: data.hasMore,
            failure: null,
          ),
        );
      case Failure<PagedResult<Location>>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }

  Future<void> _onLoadMoreRequested(
    LocationSearchLoadMoreRequested event,
    Emitter<LocationSearchState> emit,
  ) async {
    if (state.isLoadingMore || !state.hasMore) return;

    final center = state.filter?.center ?? state.currentPosition;
    if (center == null) return;

    emit(state.copyWith(isLoadingMore: true));

    final bounds = _boundsCalculator.fromCenter(
      center: center,
      boxSizeKm: state.filter?.radiusKm ?? _defaultRadiusKm,
    );
    final nextPage = state.page + 1;

    final result = await _locationService.searchLocationsWithFilter(
      query: state.query.trim(),
      bounds: bounds,
      start: state.filter?.start ?? DateTime.now(),
      end: state.filter?.end ?? DateTime.now().add(const Duration(days: 1)),
      page: nextPage,
    );

    switch (result) {
      case Success<PagedResult<Location>>(:final data):
        emit(
          state.copyWith(
            locations: [...state.locations, ...data.items],
            page: nextPage,
            hasMore: data.hasMore,
            isLoadingMore: false,
          ),
        );
      case Failure<PagedResult<Location>>(:final failure):
        emit(state.copyWith(isLoadingMore: false, failure: failure));
    }
  }

  @override
  Future<void> close() {
    _searchDebouncer.cancel();
    return super.close();
  }
}
