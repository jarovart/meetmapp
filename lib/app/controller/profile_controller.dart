import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/model/response/userfull_response.dart';
import 'package:meetmaap/app/model/response/usermyprofile_response.dart';
import 'package:meetmaap/app/controller/util/app_error_mapper.dart';
import 'package:meetmaap/app/service/authentication_service.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/service/user_service.dart';

class UserProfileController extends ChangeNotifier {
  final String? _username;

  UserProfileController(this._username);

  bool _isLoading = false;
  int? _userId;
  UserBaseResponse? _userBaseResponse;
  bool _requiresLogin = false;
  UserFullResponse? _userData;
  String? _infoMessage;
  String? _errorMessage;

  List<LocationBaseResponse> _createdLocations = [];
  List<LocationBaseResponse> _joinedLocations = [];
  List<LocationBaseResponse> _likedLocations = [];

  bool _isLoadingCreated = false;
  bool _isLoadingJoined = false;
  bool _isLoadingLiked = false;

  bool _createdLoaded = false;
  bool _joinedLoaded = false;
  bool _likedLoaded = false;

  bool _saving = false;

  bool get isLoading => _isLoading;
  bool get isSaving => _saving;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;

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

  Future<void> load(UserBaseResponse? userBaseResponse) async {
    if (_isLoading) return;

    if (userBaseResponse != null) _userBaseResponse = userBaseResponse;
    _isLoading = true;
    _infoMessage = null;
    _errorMessage = null;
    _requiresLogin = false;
    notifyListeners();

    try {
      final loggedIn = await AuthService.isLoggedIn();
      final hasUsername = _username != null && _username.isNotEmpty;
      debugPrint("1");
      if (!loggedIn && !hasUsername) {
        _requiresLogin = true;
        debugPrint("1a");
        return;
      }

      debugPrint("2");
      if (loggedIn) {
        final myUsername = await AuthService.getUsername();

        debugPrint("3");

        debugPrint("$hasUsername + $myUsername + $_username");
        if (!hasUsername || myUsername == _username) {
          _userData = await AuthService.fetchMyProfile();
          debugPrint("3a");
        }
      }

      if (_userData == null) {
        debugPrint("4");
        if (_userBaseResponse != null) {
          debugPrint("5");
          _userData = await UserService.fetchFullUserById(
            _userBaseResponse!.id,
          );
        } else if (hasUsername) {
          debugPrint("6");
          _userData = await UserService.fetchFullUserByUserName(_username);
        } else {
          debugPrint("7");
          throw Exception("userData can not be loaded.");
        }
      }

      _userId = _userData!.id;

      // reset tab data when switching profile
      _createdLocations = [];
      _joinedLocations = [];
      _likedLocations = [];
      _createdLoaded = false;
      _joinedLoaded = false;
      _likedLoaded = false;
      await loadCreatedLocations();
    } catch (e, st) {
      debugPrint('Error while loading profile: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Laden des Profils.',
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    await load(_userBaseResponse);
  }

  Future<void> loadCreatedLocations() async {
    if (_isLoadingCreated || _createdLoaded || _userId == null) return;

    _isLoadingCreated = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _createdLocations = await LocationService.getCreatedLocationsByUserId(
        _userId!,
      );
      _createdLoaded = true;
    } catch (e, st) {
      debugPrint('Error while loading created locations: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Laden der Locations.',
      );
    } finally {
      _isLoadingCreated = false;
      notifyListeners();
    }
  }

  Future<void> loadJoinedLocations() async {
    if (_isLoadingJoined || _joinedLoaded || _userId == null) return;

    _isLoadingJoined = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _joinedLocations = await LocationService.getJoinedLocationsByUserId(
        _userId!,
      );
      _joinedLoaded = true;
    } catch (e, st) {
      debugPrint('Error while loading joined locations: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Laden der Locations.',
      );
    } finally {
      _isLoadingJoined = false;
      notifyListeners();
    }
  }

  Future<void> loadLikedLocations() async {
    if (_isLoadingLiked || _likedLoaded || _userId == null) return;

    _isLoadingLiked = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _likedLocations = await LocationService.getLikedLocationsByUserId(
        _userId!,
      );
      _likedLoaded = true;
    } catch (e, st) {
      debugPrint('Error while loading liked locations: $e');
      debugPrintStack(stackTrace: st);

      _errorMessage = AppErrorMapper.toUserMessage(
        e,
        fallback: 'Fehler beim Laden der Locations.',
      );
    } finally {
      _isLoadingLiked = false;
      notifyListeners();
    }
  }
}
