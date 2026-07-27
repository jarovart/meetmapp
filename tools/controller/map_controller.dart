import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:casttime/app/config/route_config.dart';
import 'package:casttime/app/controller/debouncer.dart';
import 'package:casttime/app/model/exception/app_exception.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/app/model/response/locationfull_response.dart';
import 'package:casttime/app/service/location_service.dart';
import 'package:casttime/app/view/util/locationmarker_widget.dart';

class MapViewController extends ChangeNotifier {
  final MapController mapController;

  MapViewController({required this.mapController}) {
    searchFocusNode.addListener(_onFocusChanged);
  }

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isLoaded = false;
  List<LocationBaseResponse> _locations = [];
  LocationBaseResponse? _selectedLocation;
  LatLng _initialCenter = LatLng(51.1657, 10.4515); // Mitte von Deutschland
  LatLng? _currentPosition;
  LatLng? _mapCenterBeforeSheet;
  Object? _error;
  bool _isSearchLoading = false;
  Object? _searchError;
  LocationFullResponse? _locationToCheck;

  RangeValues _selectedRange = const RangeValues(0, 4);

  List<String> _dayOptions = [
    'Heute',
    'Morgen',
    'Übermorgen',
    '1 Woche',
    '1 Monat',
  ];

  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<LocationBaseResponse> _searchResults = [];

  Debouncer? _debouncer;
  Timer? _searchDebounce;

  List<LocationBaseResponse> get locations => _locations;
  LocationBaseResponse? get selectedLocation => _selectedLocation;
  LatLng get initialCenter => _initialCenter;
  LatLng? get currentPosition => _currentPosition;
  LatLng? get mapCenterBeforeSheet => _mapCenterBeforeSheet;
  bool get isSearchLoading => _isSearchLoading;
  bool get isOnlyOneLocation => _locationToCheck != null;
  LocationFullResponse? get locationToCheck => _locationToCheck;
  bool get hasError => _error != null;
  bool get hasSearchError => _searchError != null;
  Object? get error => _error;
  Object? get searchError => _searchError;
  FocusNode get searchFocusNode => _searchFocusNode;

  RangeValues get selectedRange => _selectedRange;
  List<String> get dayOptions => _dayOptions;
  DateTime get _startDate => _dateFromIndex(_selectedRange.start.round());
  DateTime get _endDate => _dateFromIndex(_selectedRange.end.round());

  TextEditingController get searchController => _searchController;
  List<LocationBaseResponse> get searchResults => _searchResults;

  Debouncer get debouncer => _debouncer!;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────

  set dayOptions(List<String> dayOptions) => _dayOptions = dayOptions;
  void centerOnUser() async => await _determinePosition(refreshLocation: true);

  void setDateRange(RangeValues values) {
    _selectedRange = values;
    notifyListeners();
  }

  void _onFocusChanged() {
    notifyListeners();
  }

  String setDayOptionsText(double index) {
    return _dayOptions[index.round()];
  }

  void setOnlyOneLocation(LocationFullResponse? location) =>
      _locationToCheck = location;

  void selectLocation(LocationBaseResponse? location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void updateSearchResults(List<LocationBaseResponse> results) {
    _searchResults = results;
    _searchError = null;
    _isSearchLoading = false;
    debugPrint("updateSearchResults: ${results.length}");
    notifyListeners();
  }

  void clearSearchResults() {
    _searchResults.clear();
    _searchError = null;
    _isSearchLoading = false;
    notifyListeners();
  }

  void clearSearchState() {
    _searchResults.clear();
    _searchError = null;
    _isSearchLoading = false;
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
    _debouncer ??= Debouncer(delay: const Duration(milliseconds: 1000));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLocations();
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _debouncer?.cancel();
    searchFocusNode.removeListener(_onFocusChanged);
    _searchFocusNode.dispose();
    super.dispose();
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

  LocationBaseResponse pickBestLocationFromCluster(List<Marker> markers) {
    return markers
        .map((m) => m.child)
        .whereType<LocationMarker>()
        .map((w) => w.location)
        .reduce(
          (a, b) =>
              LocationService.getLocationScore(
                    likedUserCount: a.likedUserCount,
                    joinedUserCount: a.joinedUserCount,
                    startDateTime: a.startDateTime,
                    endDateTime: a.endDateTime,
                  ) >=
                  LocationService.getLocationScore(
                    likedUserCount: b.likedUserCount,
                    joinedUserCount: b.joinedUserCount,
                    startDateTime: b.startDateTime,
                    endDateTime: b.endDateTime,
                  )
              ? a
              : b,
        );
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
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce!.cancel();
    }

    final trimmed = text.trim();

    if (trimmed.isEmpty) {
      clearSearchState();
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      if (text.length < 3) {
        clearSearchResults();
        return;
      }

      _isSearchLoading = true;
      _searchError = null;
      notifyListeners();
      try {
        final results = await LocationService.searchLocations(trimmed);

        if (_searchController.text.trim() != trimmed) return;

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

        _searchResults = results;
        _searchError = null;
      } catch (e, st) {
        if (_searchController.text.trim() != trimmed) return;
        debugPrint('Error while searching for locations in mapcontroller: $e');
        debugPrintStack(stackTrace: st);

        _searchResults = [];
        _searchError = e;
      } finally {
        if (_searchController.text.trim() == trimmed) {
          _isSearchLoading = false;
          notifyListeners();
        }
      }
    });
  }

  void closeSearch() {
    _searchDebounce?.cancel();
    _searchController.clear();
    _searchResults.clear();
    _searchError = null;
    _isSearchLoading = false;
    _searchFocusNode.unfocus();
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> _determinePosition({bool refreshLocation = false}) async {
    final result = await LocationService.getCurrentLocation();

    switch (result) {
      case LocationSuccess(:final position):
        _initialCenter = position;
        _currentPosition = position;
        mapController.move(position, 13.00);
      case LocationServiceDisabled():
        _error = result;
      case LocationPermissionDenied():
        _error = result;
      case LocationError():
        _error = result;
    }
    if (refreshLocation) {
      fetchLocations();
    }

    notifyListeners();
  }

  Future<void> fetchLocations() async {
    try {
      _error = null; // reset vorher
      debugPrint("Start: _fetchLocationsWithinWithTime");
      final bounds = mapController.camera.visibleBounds;
      _locations = await LocationService.fetchLocationsWithinWithTime(
        bounds,
        _startDate,
        _endDate,
      );
      debugPrint("Execute: _fetchLocationsWithinWithTime");
    } catch (e, st) {
      debugPrint('Exception: _fetchLocationsWithinWithTime: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // REDIRECT CALL BEHAVIOR
  // ─────────────────────────────────────────────

  void createLocation(BuildContext context, LatLng tapPosition) async {
    final router = GoRouter.of(context);

    final geoAddress = await LocationService.reverseGeocodeOSM(
      tapPosition.latitude,
      tapPosition.longitude,
    );

    final createdLocation = await router.push<LocationBaseResponse>(
      RouteConfig.getLocationCreateUrl(
        lat: tapPosition.latitude,
        lng: tapPosition.longitude,
        geoAddress: geoAddress,
      ),
    );

    if (createdLocation != null) {
      _locations.add(createdLocation);
      _selectedLocation = createdLocation;
      notifyListeners();
      mapController.move(createdLocation.position, mapController.camera.zoom);
    }
  }
}
