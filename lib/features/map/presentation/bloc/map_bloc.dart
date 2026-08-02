import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@lazySingleton
class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationService locationService;
  Timer? _searchDebounce;

  MapBloc(this.locationService) : super(MapState.initial()) {
    on<MapStarted>(_onStarted);
    on<MapBoundsChanged>(_onBoundsChanged);
    on<MapSliderChanged>(_onSliderChanged);
    on<MapSearchChanged>(_onSearchChanged);
    on<MapSearchQueryDebounced>(_onSearchQueryDebounced);
    on<MapLocationSelected>(_onLocationSelected);
    on<MapLocationDeselected>(_onLocationDeselected);
    on<MapCenterOnUserRequested>(_onCenterOnUserRequested);
    on<LocationsRequested>(_onLocationsRequested);
  }

  Future<void> _onStarted(MapStarted event, Emitter<MapState> emit) async {
    emit(
      state.copyWith(status: LocationLoadStatus.loading, clearFailure: true),
    );

    try {
      //final locations = await locationService.fetchInitialLocations(LatLngBounds(, corner2));
      List<Location> locations = [];
      emit(
        state.copyWith(
          status: LocationLoadStatus.success,
          locations: locations,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: LocationLoadStatus.failure));
    }
  }

  Future<void> _onBoundsChanged(
    MapBoundsChanged event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(bounds: event.bounds, clearFailure: true));

    final result = await locationService.fetchLocationsWithDateRange(
      event.bounds,
      state.startDate,
      state.endDate,
    );

    switch (result) {
      case Success<List<Location>>(:final data):
        emit(
          state.copyWith(
            status: LocationLoadStatus.success,
            locations: data,
            clearFailure: true,
          ),
        );
      case Failure<List<Location>>(:final failure):
        emit(
          state.copyWith(status: LocationLoadStatus.failure, failure: failure),
        );
    }
  }

  void _onSearchChanged(MapSearchChanged event, Emitter<MapState> emit) {
    emit(state.copyWith(searchQuery: event.query));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!isClosed) add(MapSearchQueryDebounced(event.query));
    });
  }

  Future<void> _onSearchQueryDebounced(
    MapSearchQueryDebounced event,
    Emitter<MapState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(
        state.copyWith(status: LocationLoadStatus.initial, locations: const []),
      );
      return;
    }
    emit(
      state.copyWith(status: LocationLoadStatus.loading, clearFailure: true),
    );
    final result = await locationService.searchLocations(event.query);
    switch (result) {
      case Success<List<Location>>(:final data):
        emit(
          state.copyWith(
            status: LocationLoadStatus.success,
            locations: data,
            clearFailure: true,
          ),
        );
      case Failure<List<Location>>(:final failure):
        emit(
          state.copyWith(status: LocationLoadStatus.failure, failure: failure),
        );
    }
  }

  Future<void> _onSliderChanged(
    MapSliderChanged event,
    Emitter<MapState> emit,
  ) async {
    emit(
      state.copyWith(
        startDate: event.startDate,
        endDate: event.endDate,
        rangeValues: event.rangeValues,
        status: LocationLoadStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await locationService.fetchLocationsWithDateRange(
      event.bounds,
      event.startDate,
      event.endDate,
    );
    switch (result) {
      case Success<List<Location>>(:final data):
        emit(
          state.copyWith(
            status: LocationLoadStatus.success,
            locations: data,
            clearFailure: true,
          ),
        );
      case Failure<List<Location>>(:final failure):
        emit(
          state.copyWith(status: LocationLoadStatus.failure, failure: failure),
        );
    }
  }

  void _onLocationSelected(MapLocationSelected event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        selectedLocation: event.location,
        currentPosition: event.location.position,
        zoom: 15,
      ),
    );
  }

  void _onLocationDeselected(
    MapLocationDeselected event,
    Emitter<MapState> emit,
  ) {
    emit(
      state.copyWith(clearSelectedLocation: true),
    ); //mapViewController.closeSearch();
  }

  Future<void> _onCenterOnUserRequested(
    MapCenterOnUserRequested event,
    Emitter<MapState> emit,
  ) async {
    final result = await locationService.getCurrentUserPosition();

    switch (result) {
      case Success<LatLng>(:final data):
        emit(
          state.copyWith(currentPosition: data, zoom: 15, clearFailure: true),
        );
      case Failure<LatLng>(:final failure):
        emit(
          state.copyWith(status: LocationLoadStatus.failure, failure: failure),
        );
    }
  }

  Future<void> _onLocationsRequested(
    LocationsRequested event,
    Emitter<MapState> emit,
  ) async {
    emit(
      state.copyWith(status: LocationLoadStatus.loading, clearFailure: true),
    );

    final result = await locationService.fetchLocation(id: 0);

    switch (result) {
      case Success<Location>(:final data):
        emit(
          state.copyWith(
            status: LocationLoadStatus.success,
            locations: [data],
            clearFailure: true,
          ),
        );

      case Failure<Location>(:final failure):
        emit(
          state.copyWith(status: LocationLoadStatus.failure, failure: failure),
        );
    }
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
