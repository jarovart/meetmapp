import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/util/locationbounds.dart';
import 'package:meetmaap/app/service/location_service.dart';

class LocationListController extends ChangeNotifier {
  LocationListController() {
    _locations = [];
    loadData();
  }

  bool _isInitialized = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _loadMoreTriggered = false;
  Object? _error;

  final TextEditingController _searchCtrl = TextEditingController();
  List<LocationBaseResponse> _locations = [];
  Timer? _searchDebounce;

  LatLng? _currentLocation;
  LatLng? _filterCenter;
  String? _filterPlaceText;
  double _filterRadiusKm = 10;
  DateTime? _filterStart;
  DateTime? _filterEnd;

  int _page = 0;
  final int _pageSize = 10;
  bool _hasMore = true;

  DateTime _resetStart = DateTime.now();
  DateTime _resetEnd = DateTime.now().add(const Duration(days: 1));

  TextEditingController get searchCtrl => _searchCtrl;
  List<LocationBaseResponse> get locations => _locations;
  String? get filterPlaceText => _filterPlaceText;
  LatLng? get filterCenter => _filterCenter;
  DateTime? get filterStart => _filterStart;
  DateTime? get filterEnd => _filterEnd;
  double get filterRadiusKm => _filterRadiusKm;

  DateTime get resetStart => _resetStart;
  DateTime get resetEnd => _resetEnd;

  bool get hasError => _error != null;
  Object? get error => _error;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get loadMoreTriggered => _loadMoreTriggered;
  bool get hasMore => _hasMore;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────

  Future<void> loadData() async {
    if (_isInitialized) return;

    await determinePosition();
    await loadLocationsByQuery();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  void setFilterSettings(
    DateTime? filterStart,
    DateTime? filterEnd,
    LatLng? filterCenter,
    String? filterPlaceText,
    double filterRadiusKm,
  ) {
    _filterStart = filterStart;
    _filterEnd = filterEnd;
    _filterCenter = filterCenter;
    _filterPlaceText = filterPlaceText;
    _filterRadiusKm = filterRadiusKm;
    notifyListeners();
  }

  Future<void> determinePosition() async {
    final result = await LocationService.getCurrentLocation();

    switch (result) {
      case LocationSuccess(:final position):
        _currentLocation = position;
      case LocationServiceDisabled():
        _error = result;
      case LocationPermissionDenied():
        _error = result;
      case LocationError():
        _error = result;
    }
    notifyListeners();
  }

  Future<void> reloadLocations() async {
    await loadLocationsByQuery();
  }

  void clearSearchResults() {
    _searchCtrl.clear();
    loadLocationsByQuery();
  }

  void onSearchChanged(String text) {
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 700), () async {
      if (text.isNotEmpty && text.length < 3) {
        return;
      }
      await loadLocationsByQuery();
    });

    notifyListeners();
  }

  bool handleScrollNotification(
    BuildContext context,
    ScrollNotification notification,
  ) {
    if (notification is! ScrollUpdateNotification &&
        notification is! OverscrollNotification) {
      return false;
    }

    final shouldLoadMore =
        notification.metrics.extentAfter < 300 &&
        hasMore &&
        !isLoading &&
        !isLoadingMore &&
        !loadMoreTriggered;

    if (shouldLoadMore) {
      _loadMoreTriggered = true;
      loadMoreLocationsByQuery().whenComplete(() {
        if (context.mounted) {
          _loadMoreTriggered = false;
        }
      });
    }

    if (notification.metrics.extentAfter >= 300) {
      _loadMoreTriggered = false;
    }

    return false;
  }

  LocationBounds _buildBoundsFromCenter({
    required LatLng center,
    required double boxSizeKm,
  }) {
    final halfKm = boxSizeKm / 2;

    final latDelta = halfKm / 111.0;
    final lngDelta =
        halfKm /
        (111.0 * cos(center.latitude * pi / 180).abs().clamp(0.01, 1.0));

    return LocationBounds(
      minLat: center.latitude - latDelta,
      maxLat: center.latitude + latDelta,
      minLng: center.longitude - lngDelta,
      maxLng: center.longitude + lngDelta,
    );
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> loadLocationsByQuery() async {
    if (_isLoading) return;
    debugPrint("loadlocations");
    final query = _searchCtrl.text.trim();
    if (query.isEmpty || query.length < 3) return;

    try {
      if (_currentLocation == null && _filterCenter == null) {
        throw NoGpsAndNoFilterLocationException();
      }

      _isLoading = true;
      _error = null;
      _page = 0;
      _hasMore = true;
      notifyListeners();

      final bounds = _buildBoundsFromCenter(
        center: _filterCenter ?? _currentLocation!,
        boxSizeKm: _filterRadiusKm,
      );

      final result = await LocationService.fetchLocationsByFilterSettings(
        query,
        bounds,
        _filterStart ?? _resetStart,
        _filterEnd ?? _resetEnd,
        page: _page,
        pageSize: _pageSize,
      );

      _locations = result.items;
      _page = 1;
      _hasMore = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while fetching locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
      _locations = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreLocationsByQuery() async {
    if (_isLoading || _isLoadingMore || !_hasMore) return;
    debugPrint("loadlocations more");
    final query = _searchCtrl.text.trim();
    if (query.isEmpty || query.length < 3) return;

    try {
      if (_currentLocation == null && _filterCenter == null) {
        throw NoGpsAndNoFilterLocationException();
      }

      _isLoadingMore = true;
      notifyListeners();

      final bounds = _buildBoundsFromCenter(
        center: _filterCenter ?? _currentLocation!,
        boxSizeKm: _filterRadiusKm,
      );

      debugPrint("loadmore1");
      final result = await LocationService.fetchLocationsByFilterSettings(
        query,
        bounds,
        _filterStart ?? _resetStart,
        _filterEnd ?? _resetEnd,
        page: _page,
        pageSize: _pageSize,
      );

      _locations.addAll(result.items);
      _page++;
      _hasMore = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while fetching more locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
