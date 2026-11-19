import 'dart:typed_data';

import 'package:latlong2/latlong.dart';

sealed class LocationEditEvent {}

class LocationEditStarted extends LocationEditEvent {}

class LocationEditTitleChanged extends LocationEditEvent {
  LocationEditTitleChanged(this.value);
  final String value;
}

class LocationEditDescriptionChanged extends LocationEditEvent {
  LocationEditDescriptionChanged(this.description);
  final String description;
}

class LocationEditStartDateChanged extends LocationEditEvent {
  LocationEditStartDateChanged(this.dateTime);
  final DateTime dateTime;
}

class LocationEditEndDateChanged extends LocationEditEvent {
  LocationEditEndDateChanged(this.dateTime);
  final DateTime dateTime;
}

class LocationEditPositionChanged extends LocationEditEvent {
  LocationEditPositionChanged(this.position);
  final LatLng position;
}

class LocationEditAddressChanged extends LocationEditEvent {
  LocationEditAddressChanged(this.address);
  final String address;
}

class LocationEditImageAdded extends LocationEditEvent {
  LocationEditImageAdded(this.bytes);
  final Uint8List bytes;
}

class LocationEditImageRemoved extends LocationEditEvent {
  LocationEditImageRemoved(this.index);
  final int index;
}

class LocationEditImagesReordered extends LocationEditEvent {
  LocationEditImagesReordered(this.oldIndex, this.newIndex);
  final int oldIndex;
  final int newIndex;
}

class LocationEditSubmitted extends LocationEditEvent {}

class LocationEditReset extends LocationEditEvent {}
