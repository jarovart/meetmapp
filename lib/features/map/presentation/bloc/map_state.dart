import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapState {
  final List<Location> locations;
  final Location? selectedLocation;
  final String searchQuery;
  final DateTime startDate;
  final DateTime endDate;
  final RangeValues rangeValues;
  final LatLng center;
  final LatLngBounds bounds;
  final double zoom;
  final LocationLoadStatus status;
  final AppFailure? failure;

  const MapState({
    required this.locations,
    required this.selectedLocation,
    required this.searchQuery,
    required this.startDate,
    required this.endDate,
    required this.rangeValues,
    required this.center,
    required this.bounds,
    required this.zoom,
    this.status = LocationLoadStatus.initial,
    this.failure,
  });

  factory MapState.initial() {
    final now = DateTime.now();

    return MapState(
      locations: [],
      selectedLocation: null,
      searchQuery: '',
      startDate: now,
      endDate: now.add(Duration(days: 1)),
      rangeValues: RangeValues(0, 4),
      center: LatLng(51.1657, 10.4515), // Deutschland
      bounds: LatLngBounds(LatLng(51.1657, 10.4515), LatLng(51.1657, 10.4515)),
      zoom: 6,
    );
  }

  MapState copyWith({
    List<Location>? locations,
    Location? selectedLocation,
    bool clearSelectedLocation = false,
    String? searchQuery,
    DateTime? startDate,
    DateTime? endDate,
    RangeValues? rangeValues,
    LatLng? center,
    LatLngBounds? bounds,
    double? zoom,
    LocationLoadStatus? status,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return MapState(
      locations: locations ?? this.locations,
      selectedLocation: clearSelectedLocation
          ? null
          : selectedLocation ?? this.selectedLocation,
      searchQuery: searchQuery ?? this.searchQuery,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      rangeValues: rangeValues ?? this.rangeValues,
      center: center ?? this.center,
      bounds: bounds ?? this.bounds,
      zoom: zoom ?? this.zoom,
      status: status ?? this.status,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}

enum LocationLoadStatus { initial, loading, success, failure }
