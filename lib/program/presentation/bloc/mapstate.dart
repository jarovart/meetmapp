import 'package:casttime/program/core/failure/appfailure.dart';
import 'package:casttime/program/domain/models/location.dart';
import 'package:latlong2/latlong.dart';

class MapState {
  final bool isLoading;
  final String? error;
  final List<Location> locations;
  final Location? selectedLocation;
  final String searchQuery;
  final LatLng center;
  final double zoom;
  final LocationLoadStatus status;
  final AppFailure? failure;

  const MapState({
    required this.isLoading,
    required this.error,
    required this.locations,
    required this.selectedLocation,
    required this.searchQuery,
    required this.center,
    required this.zoom,
    this.status = LocationLoadStatus.initial,
    this.failure,
  });

  factory MapState.initial() {
    return const MapState(
      isLoading: false,
      error: null,
      locations: [],
      selectedLocation: null,
      searchQuery: '',
      center: LatLng(51.1657, 10.4515), // Deutschland
      zoom: 6,
    );
  }

  MapState copyWith({
    bool? isLoading,
    String? error,
    List<Location>? locations,
    Location? selectedLocation,
    bool clearSelectedLocation = false,
    String? searchQuery,
    LatLng? center,
    double? zoom,
    LocationLoadStatus? status,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      locations: locations ?? this.locations,
      selectedLocation: clearSelectedLocation
          ? null
          : selectedLocation ?? this.selectedLocation,
      searchQuery: searchQuery ?? this.searchQuery,
      center: center ?? this.center,
      zoom: zoom ?? this.zoom,
      status: status ?? this.status,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}

enum LocationLoadStatus { initial, loading, success, failure }
