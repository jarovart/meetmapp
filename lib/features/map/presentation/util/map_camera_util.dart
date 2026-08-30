import 'dart:math';

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
      final up = camera.project(camera.visibleBounds.northEast);
      final bottom = camera.project(camera.visibleBounds.southWest);
      final mapWidthPx = up.y - bottom.y;

      final projected = camera.project(target);
      final shifted = Point<double>(projected.x, projected.y - mapWidthPx / 4);
      newCenter = camera.unproject(shifted);
    } else {
      final left = camera.project(camera.visibleBounds.southWest);
      final right = camera.project(camera.visibleBounds.northEast);
      final mapWidthPx = right.x - left.x;

      final projected = camera.project(target);
      final shifted = Point<double>(projected.x - mapWidthPx / 4, projected.y);
      newCenter = camera.unproject(shifted);
    }

    _mapController.move(newCenter, camera.zoom);
  }

  void restoreCenterAfterShift() {
    if (_centerBeforeShift == null) return;
    _mapController.move(_centerBeforeShift!, _mapController.camera.zoom);
    _centerBeforeShift = null;
  }
}
