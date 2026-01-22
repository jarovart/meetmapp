import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/controller/debouncer.dart';
import 'package:meetmaap/app/model/exceptions/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/location_base.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/util/locationmarker_widget.dart';

class MapViewController extends ChangeNotifier {
  final MapController mapController;

  MapViewController({required this.mapController});

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isLoaded = false;
  List<LocationBase> _locations = [];
  LocationBase? _selectedLocation;
  LatLng _initialCenter = LatLng(51.1657, 10.4515); // Mitte von Deutschland
  LatLng? _currentPosition;
  LatLng? _mapCenterBeforeSheet;

  RangeValues _selectedRange = const RangeValues(0, 4);
  final List<String> _dayOptions = [
    'Heute',
    'Morgen',
    'Übermorgen',
    '1 Woche',
    '1 Monat',
  ];

  final TextEditingController _searchController = TextEditingController();
  List<LocationBase> _searchResults = [];

  late Debouncer _debouncer;
  Timer? _searchDebounce;

  List<LocationBase> get locations => _locations;
  LocationBase? get selectedLocation => _selectedLocation;
  LatLng get initialCenter => _initialCenter;
  LatLng? get currentPosition => _currentPosition;
  LatLng? get mapCenterBeforeSheet => _mapCenterBeforeSheet;

  RangeValues get selectedRange => _selectedRange;
  List<String> get dayOptions => _dayOptions;
  DateTime get _startDate => _dateFromIndex(_selectedRange.start.round());
  DateTime get _endDate => _dateFromIndex(_selectedRange.end.round());

  TextEditingController get searchController => _searchController;
  List<LocationBase> get searchResults => _searchResults;

  Debouncer get debouncer => _debouncer;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  void centerOnUser() async => await _determinePosition();

  void setDateRange(RangeValues values) {
    _selectedRange = values;
    notifyListeners();
  }

  String setDayOptionsText(double index) {
    return _dayOptions[index.round()];
  }

  void selectLocation(LocationBase? location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void updateSearchResults(List<LocationBase> results) {
    _searchResults = results;
    debugPrint("updateSearchResults: ${results.length}");
    notifyListeners();
  }

  void clearSearchResults() {
    _searchResults.clear();
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // DATA
  // ─────────────────────────────────────────────

  Future<void> loadData() async {
    if (_isLoaded) return;
    _isLoaded = true;

    _determinePosition();
    debugPrint("Start: InitState MapPage");
    _debouncer = Debouncer(delay: Duration(milliseconds: 1000));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLocations();
    });
  }

  // ─────────────────────────────────────────────
  // MAP BEHAVIOR
  // ─────────────────────────────────────────────

  void rememberCenter() {
    _mapCenterBeforeSheet ??= mapController.camera.center;
  }

  void restoreCenter() {
    if (_mapCenterBeforeSheet == null) return;
    mapController.move(_mapCenterBeforeSheet!, mapController.camera.zoom);
    _mapCenterBeforeSheet = null;
  }

  void viewMoveTo(LatLng target) {
    mapController.move(target, mapController.camera.zoom);
  }

  void shiftTargetForView(LatLng target, {bool isMobileSheetOpen = true}) {
    final camera = mapController.camera;
    _mapCenterBeforeSheet ??= camera.center;
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

    mapController.move(newCenter, camera.zoom);
  }

  void restoreCenterAfterSheet() {
    if (_mapCenterBeforeSheet == null) return;
    mapController.move(_mapCenterBeforeSheet!, mapController.camera.zoom);
    _mapCenterBeforeSheet = null;
  }

  LocationBase pickBestLocationFromCluster(List<Marker> markers) {
    return markers
        .map((m) => (m.child as LocationMarker).location)
        .reduce((a, b) => a.getLocationScore() >= b.getLocationScore() ? a : b);
  }

  DateTime _dateFromIndex(int index) {
    final now = DateTime.now();

    return switch (index) {
      0 => DateTime(now.year, now.month, now.day), // heute 00:00
      1 => now.add(const Duration(days: 1)),
      2 => now.add(const Duration(days: 2)),
      3 => now.add(const Duration(days: 7)),
      4 => DateTime(now.year, now.month + 1, now.day),
      _ => now,
    };
  }

  void onSearchChanged(String text) {
    notifyListeners();
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce!.cancel();
      notifyListeners();
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      if (text.length < 3) {
        clearSearchResults();
        return;
      }

      try {
        final results = await LocationService.searchLocations(text);

        // nach Entfernung sortieren (falls _currentPosition != null)
        if (_currentPosition != null) {
          results.sort((a, b) {
            final distA = Distance().as(
              LengthUnit.Kilometer,
              _currentPosition!,
              a.position,
            );
            final distB = Distance().as(
              LengthUnit.Kilometer,
              _currentPosition!,
              b.position,
            );
            return distA.compareTo(distB);
          });
        }
        updateSearchResults(results);
      } catch (e) {
        //ExceptionMessage.showError(context, "Suche fehlgeschlagen");
        debugPrint("Suche fehlgeschlagen");
      }
    });
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> _determinePosition() async {
    final result = await LocationService.getCurrentLocation();

    //if (!mounted) return; // Ist das Widget noch im Baum?
    switch (result) {
      case LocationSuccess(:final position):
        _initialCenter = position;
        _currentPosition = position;
        mapController.move(position, 13.00); //todo auf 15 ändern
      case LocationServiceDisabled():
        debugPrint("Standortdienste sind deaktiviert");
      //ExceptionMessage.showError(context, "Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        debugPrint("Standort-Berechtigung verweigert");
      //ExceptionMessage.showError(context, "Standort-Berechtigung verweigert");
      case LocationError(:final message):
        debugPrint("Fehler: $message");
      //ExceptionMessage.showError(context, "Fehler: $message");
    }
    notifyListeners();
  }

  Future<void> fetchLocations() async {
    try {
      debugPrint("Start: _fetchLocationsWithinWithTime");
      final bounds = mapController.camera.visibleBounds;
      _locations = await LocationService.fetchLocationsWithinWithTime(
        bounds,
        _startDate,
        _endDate,
      );
      debugPrint("Execute: _fetchLocationsWithinWithTime");
    } catch (e) {
      debugPrint("Exception: _fetchLocationsWithinWithTime");
      //ExceptionMessage.showError(context, "Fehler beim Laden der Locations");
    } finally {
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // REDIRECT CALL BEHAVIOR
  // ─────────────────────────────────────────────

  void createLocation(BuildContext context, LatLng tapPosition) async {
    final geoAddress = await LocationService.reverseGeocodeOSM(
      tapPosition.latitude,
      tapPosition.longitude,
    );

    final createdLocation = await context.push<LocationBase>(
      "/locationcreate",
      extra: {
        'lat': tapPosition.latitude,
        'lng': tapPosition.longitude,
        'geoAddress': geoAddress,
      },
    );

    if (createdLocation != null) {
      _locations.add(createdLocation);
      _selectedLocation = createdLocation;

      notifyListeners();
      mapController.move(createdLocation.position, mapController.camera.zoom);
    }
  }
}
