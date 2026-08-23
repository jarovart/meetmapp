import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

sealed class MapEvent {}

class MapStarted extends MapEvent {}

class MapBoundsChanged extends MapEvent {
  final LatLngBounds bounds;

  MapBoundsChanged({required this.bounds});
}

class MapSearchChanged extends MapEvent {
  final String query;

  MapSearchChanged(this.query);
}

class MapSliderChanged extends MapEvent {
  final LatLngBounds bounds;
  final RangeValues rangeValues;
  final DateTime startDate;
  final DateTime endDate;

  MapSliderChanged({
    required this.bounds,
    required this.rangeValues,
    required this.startDate,
    required this.endDate,
  });
}

class MapSearchQueryDebounced extends MapEvent {
  final String query;

  MapSearchQueryDebounced(this.query);
}

class MapLocationSelected extends MapEvent {
  final Location location;

  MapLocationSelected(this.location);
}

class MapLocationDeselected extends MapEvent {}

class MapGeoLocationChanged extends MapEvent {}

class LocationsRequested extends MapEvent {}
