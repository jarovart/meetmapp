import 'dart:typed_data';

import 'package:latlong2/latlong.dart';

sealed class LocationCreateEvent {}

class LocationCreateStarted extends LocationCreateEvent {}

class LocationImageAdded extends LocationCreateEvent {
  LocationImageAdded(this.bytes);
  final Uint8List bytes;
}

class LocationImageRemoved extends LocationCreateEvent {
  LocationImageRemoved(this.index);
  final int index;
}

class LocationImagesReordered extends LocationCreateEvent {
  LocationImagesReordered(this.oldIndex, this.newIndex);
  final int oldIndex;
  final int newIndex;
}

class LocationStartDateChanged extends LocationCreateEvent {
  LocationStartDateChanged(this.dateTime);
  final DateTime dateTime;
}

class LocationEndDateChanged extends LocationCreateEvent {
  LocationEndDateChanged(this.dateTime);
  final DateTime dateTime;
}

class LocationCreateSubmitted extends LocationCreateEvent {
  LocationCreateSubmitted({
    required this.title,
    required this.description,
    required this.address,
  });
  final String title;
  final String description;
  final String address;
}

class LocationCreateReset extends LocationCreateEvent {}

class LocationPositionChanged extends LocationCreateEvent {
  LocationPositionChanged(this.position);
  final LatLng position;
}

class LocationGeocodeRequested extends LocationCreateEvent {
  LocationGeocodeRequested(this.position);
  final LatLng position;
}
