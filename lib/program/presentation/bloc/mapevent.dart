import 'package:casttime/program/domain/models/location.dart';
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

class MapLocationSelected extends MapEvent {
  final Location location;

  MapLocationSelected(this.location);
}

class MapLocationDeselected extends MapEvent {}

class MapCenterOnUserRequested extends MapEvent {}

class LocationsRequested extends MapEvent {}
