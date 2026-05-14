import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/service/user_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';

class UserListController extends ChangeNotifier {
  UserListController() {
    _users = [];
    loadData();
  }

  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isInitialized = false;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _loadMoreTriggered = false;
  String? _errorMessage;

  final TextEditingController _searchCtrl = TextEditingController();
  List<UserBaseResponse> _users = [];
  Timer? _searchDebounce;

  int _page = 0;
  final int _pageSize = 10;
  bool _hasMore = true;

  List<UserBaseResponse> get users => _users;
  TextEditingController get searchCtrl => _searchCtrl;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────
  set loadMoreTriggered(bool value) => _loadMoreTriggered = value;
  // ─────────────────────────────────────────────
  // FUNCTIONS
  // ─────────────────────────────────────────────

  Future<void> loadData() async {
    if (_isInitialized) return;

    await loadUsersByQuery();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  Future<void> reloadUsers() async {
    await loadUsersByQuery();
  }

  void clearSearchResults() {
    _searchCtrl.clear();
    loadUsersByQuery();
  }

  void onSearchChanged(String text) async {
    if (_searchDebounce?.isActive ?? false) {
      _searchDebounce!.cancel();
    }

    _searchDebounce = Timer(const Duration(milliseconds: 1000), () async {
      if (text.isNotEmpty && text.length < 3) {
        //clearSearchResults(); //TODO: check bug here
        return;
      }

      await loadUsersByQuery();
    });
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
        !_loadMoreTriggered;

    if (shouldLoadMore) {
      loadMoreTriggered = true;
      loadMoreUsersByQuery().whenComplete(() {
        if (context.mounted) {
          loadMoreTriggered = false;
        }
      });
    }

    if (notification.metrics.extentAfter >= 300) {
      loadMoreTriggered = false;
    }

    return false;
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> loadUsersByQuery() async {
    if (_isLoading) return;
    debugPrint("loadUsers");
    final query = _searchCtrl.text.trim();
    if (query.isEmpty || query.length < 3) return;

    try {
      _isLoading = true;
      _errorMessage = null;
      _page = 0;
      _hasMore = true;
      notifyListeners();

      final result = await UserService.fetchUsersByQuery(
        query,
        page: _page,
        pageSize: _pageSize,
      );

      _users = result.items;
      _page = 1;
      _hasMore = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while fetching users: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Abrufen der Benutzerliste.',
      );
      _users = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreUsersByQuery() async {
    if (_isLoading || _isLoadingMore || !_hasMore) return;
    debugPrint("loadUsers more");
    final query = _searchCtrl.text.trim();
    if (query.isEmpty || query.length < 3) return;

    try {
      _isLoadingMore = true;
      notifyListeners();

      debugPrint("loadmore1");
      final result = await UserService.fetchUsersByQuery(
        query,
        page: _page,
        pageSize: _pageSize,
      );

      _users.addAll(result.items);
      _page++;
      _hasMore = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while fetching more users: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Weitere Benutzer konnten nicht geladen werden.',
      );
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }
}
