import 'dart:async';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/model/exception/geolocationpermission_exception.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';

class LocationListController extends ChangeNotifier {
  LocationListController() {
    _futureLocations = Future.value([]);
    loadData();
  }

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isLoaded = false;
  bool _isLoading = false;
  String? _errorMessage;

  final TextEditingController _searchCtrl = TextEditingController();
  late Future<List<LocationBaseResponse>> _futureLocations;
  LatLng? _currentLocation;
  LatLng? _filterCenter;
  String? _filterPlaceText; // z.B. "Bremen"
  double _filterRadiusKm = 10;
  DateTime? _filterStart;
  DateTime? _filterEnd;

  bool _loaded = false;
  int _page = 0;
  final int _pageSize = 20;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  List<LocationBaseResponse> _locations = [];

  DateTime _resetStart = DateTime.now();
  DateTime _resetEnd = DateTime.now().add(const Duration(days: 1));

  Timer? _searchDebounce;

  Future<List<LocationBaseResponse>> get futureLocations => _futureLocations;
  TextEditingController get searchCtrl => _searchCtrl;
  DateTime? get filterStart => _filterStart;
  DateTime? get filterEnd => _filterEnd;
  String? get filterPlaceText => _filterPlaceText;
  double get filterRadiusKm => _filterRadiusKm;

  DateTime get resetStart => _resetStart;
  DateTime get resetEnd => _resetEnd;

  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  List<LocationBaseResponse> get locations => _locations;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────

  void setFilterSettings(
    DateTime? filterStart,
    DateTime? filterEnd,
    String? filterPlaceText,
    double filterRadiusKm,
  ) {
    _filterStart = filterStart;
    _filterEnd = filterEnd;
    _filterPlaceText = filterPlaceText;
    _filterRadiusKm = filterRadiusKm;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // DATA
  // ─────────────────────────────────────────────

  Future<void> loadData() async {
    if (_isLoaded) return;
    _isLoaded = true;

    determinePosition();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  void reloadLocations() {
    _errorMessage = null;
    _futureLocations = _fetchLocationsByFilterSettings();
  }

  void clearSearchResults() {
    _searchCtrl.clear();
    _futureLocations = Future.value([]);
    notifyListeners();
  }

  void resetViewSettings() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
  }

  void onSearchChanged(String text) {
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce!.cancel();
    }

    _searchDebounce = Timer(const Duration(milliseconds: 1000), () async {
      if (text.isNotEmpty && text.length < 3) {
        //clearSearchResults(); //TODO: check bug here
        return;
      }

      _futureLocations = _fetchLocationsByFilterSettings();
    });
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> determinePosition() async {
    final result = await LocationService.getCurrentLocation();

    switch (result) {
      case LocationSuccess(:final position):
        _currentLocation = position;
      case LocationServiceDisabled():
        debugPrint("Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        debugPrint("Standort-Berechtigung verweigert");
      case LocationError(:final message):
        debugPrint("Fehler: $message");
    }

    _futureLocations = _fetchLocationsByFilterSettings();
  }

  Future<List<LocationBaseResponse>> _fetchLocationsByFilterSettings() async {
    debugPrint("_fetchLocationsByFilterSettings called");
    resetViewSettings();
    try {
      if (_currentLocation == null && _filterCenter == null) {
        throw Exception("No gps and no filter location available");
      }
      final query = _searchCtrl.text.trim();
      final list = await LocationService.fetchLocationsByFilterSettings(
        query,
        _filterCenter ?? _currentLocation!,
        _filterRadiusKm,
        _filterStart ?? _resetStart,
        _filterEnd ?? _resetEnd,
        page: 0,
        pageSize: 10,
      );
      _errorMessage = null;
      return list.items;
    } catch (e, st) {
      debugPrint('Error while fetching locations: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Abrufen der Locations.',
      );
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadLocationsByQuery() async {
    if (_isLoading || _loaded) return;
    try {
      if (_currentLocation == null && _filterCenter == null) {
        throw CustomAppException("No gps and no filter location available");
      }
      _isLoading = true;
      _errorMessage = null;
      _page = 0;
      _hasMore = true;
      notifyListeners();

      final query = _searchCtrl.text.trim();
      final result = await LocationService.fetchLocationsByFilterSettings(
        query,
        _filterCenter ?? _currentLocation!,
        _filterRadiusKm,
        _filterStart ?? _resetStart,
        _filterEnd ?? _resetEnd,
        page: _page,
        pageSize: _pageSize,
      );

      _locations = result.items;
      _loaded = true;
      _page = 1;
      _hasMore = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while fetching locations: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Abrufen der Locations.',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreLocationsByQuery() async {
    if (_isLoadingMore || _isLoading || !_hasMore) {
      return;
    }

    _isLoadingMore = true;
    notifyListeners();

    try {
      final query = _searchCtrl.text.trim();
      final result = await LocationService.fetchLocationsByFilterSettings(
        query,
        _filterCenter ?? _currentLocation!,
        _filterRadiusKm,
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

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Weitere Locations konnten nicht geladen werden.',
      );
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
