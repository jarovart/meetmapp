import 'package:bloc/bloc.dart';
import 'package:casttime/program/application/services/location_service.dart';
import 'package:casttime/program/core/appresult.dart';
import 'package:casttime/program/domain/models/location.dart';
import 'package:casttime/program/presentation/bloc/mapevent.dart';
import 'package:casttime/program/presentation/bloc/mapstate.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationService locationService;

  MapBloc(this.locationService) : super(MapState.initial()) {
    on<MapStarted>(_onStarted);
    on<MapBoundsChanged>(_onBoundsChanged);
    on<MapSearchChanged>(_onSearchChanged);
    on<MapLocationSelected>(_onLocationSelected);
    on<MapLocationDeselected>(_onLocationDeselected);
    on<MapCenterOnUserRequested>(_onCenterOnUserRequested);
    on<LocationsRequested>(_onLocationsRequested);
  }

  Future<void> _onStarted(MapStarted event, Emitter<MapState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      //final locations = await locationService.fetchInitialLocations(LatLngBounds(, corner2));
      List<Location> locations = [];
      emit(state.copyWith(isLoading: false, locations: locations, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onBoundsChanged(
    MapBoundsChanged event,
    Emitter<MapState> emit,
  ) async {
    debugPrint("bloc event: ${event.bounds}");
    final result = await locationService.fetchLocationsInView(
      bounds: event.bounds,
    );
    switch (result) {
      case Success<List<Location>>(:final data):
        debugPrint("bloc result: ${result.data}");
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

  Future<void> _onSearchChanged(
    MapSearchChanged event,
    Emitter<MapState> emit,
  ) async {
    emit(
      state.copyWith(
        searchQuery: event.query,
        status: LocationLoadStatus.loading,
        error: null,
      ),
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

  void _onLocationSelected(MapLocationSelected event, Emitter<MapState> emit) {
    emit(
      state.copyWith(
        selectedLocation: event.location,
        center: event.location.position,
        zoom: 15,
      ),
    );
  }

  void _onLocationDeselected(
    MapLocationDeselected event,
    Emitter<MapState> emit,
  ) {
    emit(state.copyWith(clearSelectedLocation: true));
  }

  Future<void> _onCenterOnUserRequested(
    MapCenterOnUserRequested event,
    Emitter<MapState> emit,
  ) async {
    try {
      final position = await locationService.getCurrentUserPosition();

      emit(state.copyWith(center: position, zoom: 15, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
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
}
