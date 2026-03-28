import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/service/location_service.dart';

class LocationDetailsController extends ChangeNotifier {
  final LocationBaseResponse _locationBase;

  LocationDetailsController(this._locationBase);
  // ─────────────────────────────────────────────
  // STATE
  // ─────────────────────────────────────────────
  bool _isLoading = false;
  String? _errorMessage;
  LocationFullResponse? _locationFull;
  UserMyProfileResponse? _myProfile;

  bool _isLiked = false;
  bool _isJoined = false;
  int _likedUserCount = 0;
  int _joinedUserCount = 0;

  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _myProfile != null;
  LocationFullResponse? get locationFull => _locationFull;

  bool get isLiked => _isLiked;
  bool get isJoined => _isJoined;
  int get likedUserCount => _likedUserCount;
  int get joinedUserCount => _joinedUserCount;

  // ─────────────────────────────────────────────
  // STATE MUTATION
  // ─────────────────────────────────────────────

  // ─────────────────────────────────────────────
  // FUNCTIONS
  // ─────────────────────────────────────────────

  Future<void> load() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      if (await AuthRepository.isLoggedIn()) {
        _myProfile = await AuthRepository.getMyUserProfile();
      }

      _locationFull = _locationBase is LocationFullResponse
          // ignore: unnecessary_cast
          ? _locationBase as LocationFullResponse
          : await LocationService.fetchFullLocation(_locationBase.id);
      _likedUserCount = _locationFull!.likedUserCount;
      _joinedUserCount = _locationFull!.joinedUserCount;
      _isLiked = _locationFull!.likedByCurrentUser ?? false;
      _isJoined = _locationFull!.joinedByCurrentUser ?? false;
    } catch (e) {
      _errorMessage = "Error loading location details: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────
  // API CALL BEHAVIOR
  // ─────────────────────────────────────────────

  Future<void> toggleLike() async {
    if (_myProfile == null || _locationFull == null) return;

    final previousLiked = _isLiked;
    final previousCount = _likedUserCount;

    _isLiked = !_isLiked;
    _likedUserCount += _isLiked ? 1 : -1;
    notifyListeners();

    try {
      if (_isLiked) {
        await LocationService.like(_locationFull!.id);
      } else {
        await LocationService.unlike(_locationFull!.id);
      }
    } catch (e) {
      _isLiked = previousLiked;
      _likedUserCount = previousCount;
      _errorMessage = "Error toggling like: $e";
      notifyListeners();
    }
  }

  Future<void> toggleJoin() async {
    if (_myProfile == null || _locationFull == null) return;

    final previousJoined = _isJoined;
    final previousCount = _joinedUserCount;

    _isJoined = !_isJoined;
    _joinedUserCount += _isJoined ? 1 : -1;
    notifyListeners();

    try {
      if (_isJoined) {
        await LocationService.join(_locationFull!.id);
      } else {
        await LocationService.unjoin(_locationFull!.id);
      }
    } catch (e) {
      _isJoined = previousJoined;
      _joinedUserCount = previousCount;
      _errorMessage = "Error toggling join: $e";
      notifyListeners();
    }
  }
}
