import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/debouncer.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/model/response/userfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/service/authentication_service.dart';
import 'package:meetmaap/app/service/user_service.dart';

class UserProfileController extends ChangeNotifier {
  final String? _username;

  UserProfileController(this._username);

  bool _isLoading = false;
  Debouncer? _debouncer;
  int? _userId;
  UserBaseResponse? _userBaseResponse;
  UserFullResponse? _userData;
  Object? _error;

  List<LocationBaseResponse> _createdLocations = [];
  List<LocationBaseResponse> _joinedLocations = [];
  List<LocationBaseResponse> _likedLocations = [];

  bool _isLoadingCreated = false;
  bool _isLoadingJoined = false;
  bool _isLoadingLiked = false;

  bool _createdLoaded = false;
  bool _joinedLoaded = false;
  bool _likedLoaded = false;

  int _createdPage = 0;
  int _joinedPage = 0;
  int _likedPage = 0;

  final int _createdPageSize = 10;
  final int _joinedPageSize = 10;
  final int _likedPageSize = 10;

  bool _isLoadingMoreCreated = false;
  bool _isLoadingMoreJoined = false;
  bool _isLoadingMoreLiked = false;

  bool _hasMoreCreated = true;
  bool _hasMoreJoined = true;
  bool _hasMoreLiked = true;

  bool _saving = false;

  bool get isLoading => _isLoading;
  bool get isSaving => _saving;
  bool get hasError => _error != null;
  Object? get error => _error;
  Debouncer get debouncer => _debouncer!;

  UserFullResponse? get userData => _userData;
  UserMyProfileResponse? get myProfile => _userData is UserMyProfileResponse
      ? _userData as UserMyProfileResponse
      : null;

  bool get hasUserProfile => _userBaseResponse != null || _userData != null;

  bool get isMyProfile =>
      _userData != null && _userData is UserMyProfileResponse;

  String get displayUsername =>
      _userData?.username ?? _userBaseResponse?.username ?? '';

  String get displayFirstName =>
      _userData?.firstName ?? _userBaseResponse?.firstName ?? '';

  String get displayLastName =>
      _userData?.lastName ?? _userBaseResponse?.lastName ?? '';

  String? get displayProfileImageUrl =>
      _userData?.profileImage?.imageUrl ??
      _userBaseResponse?.profileImage?.imageUrl;

  List<LocationBaseResponse> get createdLocations => _createdLocations;
  List<LocationBaseResponse> get joinedLocations => _joinedLocations;
  List<LocationBaseResponse> get likedLocations => _likedLocations;

  bool get isLoadingCreated => _isLoadingCreated;
  bool get isLoadingJoined => _isLoadingJoined;
  bool get isLoadingLiked => _isLoadingLiked;

  bool get isLoadingMoreCreated => _isLoadingMoreCreated;
  bool get hasMoreCreated => _hasMoreCreated;

  Future<void> load(UserBaseResponse? userBaseResponse) async {
    if (_isLoading) return;

    if (userBaseResponse != null) _userBaseResponse = userBaseResponse;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final loggedIn = await AuthService.isLoggedIn();
      final hasUsername = _username != null && _username.isNotEmpty;
      if (!loggedIn && !hasUsername) {
        return;
      }

      if (loggedIn) {
        final myUsername = await AuthService.getUsername();

        debugPrint("$hasUsername + $myUsername + $_username");
        if (!hasUsername || myUsername == _username || _username == "me") {
          _userData = await AuthService.fetchMyProfile();
        }
      }

      if (_userData == null) {
        if (_userBaseResponse != null) {
          _userData = await UserService.fetchFullUserById(
            _userBaseResponse!.id,
          );
        } else if (hasUsername) {
          _userData = await UserService.fetchFullUserByUserName(_username);
        } else {
          throw LocationCouldNotBeLoadedException();
        }
      }

      _userId = _userData!.id;
      _createdLocations = [];
      _joinedLocations = [];
      _likedLocations = [];
      _createdLoaded = false;
      _joinedLoaded = false;
      _likedLoaded = false;
      _debouncer ??= Debouncer(delay: const Duration(milliseconds: 1000));

      _createdPage = 0;
      _isLoadingMoreCreated = false;
      _hasMoreCreated = true;

      await loadCreatedLocations();
    } catch (e, st) {
      debugPrint('Error while loading profile: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _debouncer?.cancel();
    super.dispose();
  }

  Future<void> reload() async {
    await load(_userBaseResponse);
  }

  Future<void> loadCreatedLocations() async {
    if (_isLoadingCreated || _createdLoaded || _userId == null) return;

    _isLoadingCreated = true;
    _error = null;
    _createdPage = 0;
    _hasMoreCreated = true;
    notifyListeners();

    try {
      final result = await UserService.getCreatedLocationsByUserIdPaged(
        _userId!,
        page: 0,
        pageSize: _createdPageSize,
      );
      _createdLocations = result.items;
      _createdLoaded = true;
      _createdPage = 1;
      _hasMoreCreated = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while loading created locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingCreated = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCreatedLocations() async {
    if (_isLoadingMoreCreated ||
        _isLoadingCreated ||
        !_hasMoreCreated ||
        _userId == null) {
      return;
    }

    _isLoadingMoreCreated = true;
    notifyListeners();

    try {
      final result = await UserService.getCreatedLocationsByUserIdPaged(
        _userId!,
        page: _createdPage,
        pageSize: _createdPageSize,
      );

      _createdLocations.addAll(result.items);
      _createdPage++;
      _hasMoreCreated = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while loading more created locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingMoreCreated = false;
      notifyListeners();
    }
  }

  Future<void> loadJoinedLocations() async {
    if (_isLoadingJoined || _joinedLoaded || _userId == null) return;

    _isLoadingJoined = true;
    _error = null;
    _joinedPage = 0;
    _hasMoreJoined = true;
    notifyListeners();

    try {
      final result = await UserService.getJoinedLocationsByUserIdPaged(
        _userId!,
        page: 0,
        pageSize: _joinedPageSize,
      );
      _joinedLocations = result.items;
      _joinedLoaded = true;
      _joinedPage = 1;
      _hasMoreJoined = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while loading joined locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingJoined = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreJoinedLocations() async {
    if (_isLoadingMoreJoined ||
        _isLoadingJoined ||
        !_hasMoreJoined ||
        _userId == null) {
      return;
    }

    _isLoadingMoreJoined = true;
    notifyListeners();

    try {
      final result = await UserService.getJoinedLocationsByUserIdPaged(
        _userId!,
        page: _joinedPage,
        pageSize: _joinedPageSize,
      );

      _joinedLocations.addAll(result.items);
      _joinedPage++;
      _hasMoreJoined = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while loading more joined locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingMoreJoined = false;
      notifyListeners();
    }
  }

  Future<void> loadLikedLocations() async {
    if (_isLoadingLiked || _likedLoaded || _userId == null) return;

    _isLoadingLiked = true;
    _error = null;
    _likedPage = 0;
    _hasMoreLiked = true;
    notifyListeners();

    try {
      final result = await UserService.getLikedLocationsByUserIdPaged(
        _userId!,
        page: 0,
        pageSize: _likedPageSize,
      );
      _likedLocations = result.items;
      _likedLoaded = true;
      _likedPage = 1;
      _hasMoreLiked = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while loading liked locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingLiked = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreLikedLocations() async {
    if (_isLoadingMoreLiked ||
        _isLoadingLiked ||
        !_hasMoreLiked ||
        _userId == null) {
      return;
    }

    _isLoadingMoreLiked = true;
    notifyListeners();

    try {
      final result = await UserService.getLikedLocationsByUserIdPaged(
        _userId!,
        page: _likedPage,
        pageSize: _likedPageSize,
      );

      _likedLocations.addAll(result.items);
      _likedPage++;
      _hasMoreLiked = result.hasMore;
    } catch (e, st) {
      debugPrint('Error while loading more liked locations: $e');
      debugPrintStack(stackTrace: st);

      _error = e;
    } finally {
      _isLoadingMoreLiked = false;
      notifyListeners();
    }
  }
}
