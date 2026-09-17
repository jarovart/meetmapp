import 'dart:math';
import 'dart:ui';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapCameraUtil {
  MapCameraUtil(this._mapController);

  final MapController _mapController;
  LatLng? _centerBeforeShift;

  void rememberCenter() {
    _centerBeforeShift ??= _mapController.camera.center;
  }

  void viewMoveTo(LatLng target) {
    _mapController.move(target, _mapController.camera.zoom);
  }

  void shiftTargetForView(LatLng target, bool isMobileSheetOpen) {
    final camera = _mapController.camera;
    _centerBeforeShift ??= camera.center;
    final LatLng newCenter;
    if (isMobileSheetOpen) {
      final up = camera.latLngToScreenOffset(camera.visibleBounds.northEast);
      final bottom = camera.latLngToScreenOffset(
        camera.visibleBounds.southWest,
      );
      final mapWidthPx = up.dy - bottom.dy;

      final projected = camera.latLngToScreenOffset(target);
      final shifted = Offset(projected.dx, projected.dy - mapWidthPx / 3.3);
      newCenter = camera.screenOffsetToLatLng(shifted);
    } else {
      final left = camera.latLngToScreenOffset(camera.visibleBounds.southWest);
      final right = camera.latLngToScreenOffset(camera.visibleBounds.northEast);
      final mapWidthPx = right.dx - left.dx;

      final projected = camera.latLngToScreenOffset(target);
      final shifted = Offset(projected.dx - mapWidthPx / 4, projected.dy);
      newCenter = camera.screenOffsetToLatLng(shifted);
    }

    _mapController.move(newCenter, camera.zoom);
  }

  void restoreCenterAfterShift() {
    if (_centerBeforeShift == null) return;
    _mapController.move(_centerBeforeShift!, _mapController.camera.zoom);
    _centerBeforeShift = null;
  }
}
