import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/service/user_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';

class UserListController extends ChangeNotifier {
  UserListController() {
    _futureUsers = Future.value([]);
    loadData();
  }

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isLoaded = false;
  bool _isLoading = false;
  String? _errorMessage;
  final TextEditingController _searchCtrl = TextEditingController();
  late Future<List<UserBaseResponse>> _futureUsers;
  Timer? _searchDebounce;

  Future<List<UserBaseResponse>> get futureUsers => _futureUsers;
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

    _futureUsers = _fetchUsersByQuery();
  }

  Future<void> reloadLocations() async {
    _errorMessage = null;
    _futureUsers = _fetchUsersByQuery();
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

      _futureUsers = _fetchUsersByQuery();
    });
  }

  void clearSearchResults() {
    _searchCtrl.clear();
    _futureUsers = Future.value([]);
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
      final result = await UserService.fetchUsersByQuery(
        query,
        page: 0,
        pageSize: 20,
      );
      return result.items;
    } catch (e, st) {
      debugPrint('Error while loading users: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Laden der Locations.',
      );
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
