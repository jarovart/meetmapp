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
    _locations = [];
    loadData();
  }

  bool _isInitialized = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;

  final TextEditingController _searchCtrl = TextEditingController();
  List<LocationBaseResponse> _locations = [];

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

  Timer? _searchDebounce;

  TextEditingController get searchCtrl => _searchCtrl;
  List<LocationBaseResponse> get locations => _locations;
  String? get filterPlaceText => _filterPlaceText;
  LatLng? get filterCenter => _filterCenter;
  DateTime? get filterStart => _filterStart;
  DateTime? get filterEnd => _filterEnd;
  double get filterRadiusKm => _filterRadiusKm;

  DateTime get resetStart => _resetStart;
  DateTime get resetEnd => _resetEnd;

  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> loadData() async {
    if (_isInitialized) return;
    _isInitialized = true;

    await determinePosition();
    await loadLocationsByQuery();
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
        debugPrint("Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        debugPrint("Standort-Berechtigung verweigert");
      case LocationError(:final message):
        debugPrint("Fehler: $message");
    }
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

  Future<void> loadLocationsByQuery() async {
    if (_isLoading) return;
    debugPrint("loadlocations");

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
      _page = 1;
      _hasMore = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while fetching locations: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Abrufen der Locations.',
      );
      _locations = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreLocationsByQuery() async {
    if (_isLoading || _isLoadingMore || !_hasMore) return;
    debugPrint("loadlocations more");

    try {
      if (_currentLocation == null && _filterCenter == null) {
        throw CustomAppException("No gps and no filter location available");
      }

      _isLoadingMore = true;
      notifyListeners();

      final query = _searchCtrl.text.trim();
      debugPrint("loadmore1");
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
