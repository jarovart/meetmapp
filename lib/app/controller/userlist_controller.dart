import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/service/user_service.dart';

class UserListController extends ChangeNotifier {
  UserListController() {
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
  late Future<List<UserBaseResponse>> _futureLocations;
  Timer? _searchDebounce;

  Future<List<UserBaseResponse>> get futureLocations => _futureLocations;
  TextEditingController get searchCtrl => _searchCtrl;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────

  // ─────────────────────────────────────────────
  // FUNCTIONS
  // ─────────────────────────────────────────────

  Future<void> loadData() async {
    if (_isLoaded) return;
    _isLoaded = true;

    _futureLocations = _fetchUsersByQuery();
  }

  Future<void> reloadLocations() async {
    _errorMessage = null;
    _futureLocations = _fetchUsersByQuery();
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

      _futureLocations = _fetchUsersByQuery();
    });
  }

  void clearSearchResults() {
    _searchCtrl.clear();
    _futureLocations = Future.value([]);
    notifyListeners();
  }

  void activateLoadingState() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<List<UserBaseResponse>> _fetchUsersByQuery() async {
    debugPrint("_fetchUsersByFilterSettings called");
    try {
      _isLoading = true;
      activateLoadingState();
      final query = _searchCtrl.text.trim();
      final list = await UserService.fetchUsersByQuery(query);
      return list;
    } catch (e) {
      _errorMessage = "Error fetching locations: $e";
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
