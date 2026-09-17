import 'dart:math';
import 'package:flutter_map/flutter_map.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';

@lazySingleton
class LocationBoundsCalculator {
  const LocationBoundsCalculator();

  LatLngBounds fromCenter({required LatLng center, required double boxSizeKm}) {
    final halfKm = boxSizeKm / 2;
    final latDelta = halfKm / 111.0;
    final lngDelta =
        halfKm /
        (111.0 * cos(center.latitude * pi / 180).abs().clamp(0.01, 1.0));

    return LatLngBounds(
      LatLng(center.latitude - latDelta, center.longitude - lngDelta),
      LatLng(center.latitude + latDelta, center.longitude + lngDelta),
    );
  }
}
