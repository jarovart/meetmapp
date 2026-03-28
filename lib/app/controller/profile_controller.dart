import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/user_repository.dart';
import 'package:meetmaap/app/service/location_service.dart';

class UserProfileController extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  UserFullResponse? _userData;
  int? _loadedUserId;

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

  bool get canEdit => _userData is UserMyProfileResponse;

  List<LocationBaseResponse> get createdLocations => _createdLocations;
  List<LocationBaseResponse> get joinedLocations => _joinedLocations;
  List<LocationBaseResponse> get likedLocations => _likedLocations;

  bool get isLoadingCreated => _isLoadingCreated;
  bool get isLoadingJoined => _isLoadingJoined;
  bool get isLoadingLiked => _isLoadingLiked;

  Future<void> load({int? userId}) async {
    if (_isLoading) return;
    if (userId == null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _loadedUserId = userId;

      final myUserId = await AuthRepository.getUserId();

      if (myUserId != null && myUserId == userId) {
        final me = await UserRepository.fetchMyProfile();
        _userData = me;
      } else {
        final other = await UserRepository.fetchFullUserById(userId);
        _userData = other;
      }

      // reset tab data when switching profile
      _createdLocations = []; //TODO: implement logic
      _joinedLocations = [];
      _likedLocations = [];
      _createdLoaded = false;
      _joinedLoaded = false;
      _likedLoaded = false;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    final userId = _loadedUserId;
    if (userId == null) return;
    await load(userId: userId);
  }

  Future<void> loadCreatedLocations() async {
    final userId = _loadedUserId;
    if (userId == null || _isLoadingCreated || _createdLoaded) return;

    _isLoadingCreated = true;
    notifyListeners();

    try {
      _createdLocations = await LocationService.getCreatedLocationsByUserId(
        userId,
      );
      _createdLoaded = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingCreated = false;
      notifyListeners();
    }
  }

  Future<void> loadJoinedLocations() async {
    final userId = _loadedUserId;
    if (userId == null || _isLoadingJoined || _joinedLoaded) return;

    _isLoadingJoined = true;
    notifyListeners();

    try {
      _joinedLocations = await LocationService.getJoinedLocationsByUserId(
        userId,
      );
      _joinedLoaded = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingJoined = false;
      notifyListeners();
    }
  }

  Future<void> loadLikedLocations() async {
    final userId = _loadedUserId;
    if (userId == null || _isLoadingLiked || _likedLoaded) return;

    _isLoadingLiked = true;
    notifyListeners();

    try {
      _likedLocations = await LocationService.getLikedLocationsByUserId(userId);
      _likedLoaded = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingLiked = false;
      notifyListeners();
    }
  }

  Future<void> updateMyProfile({
    required String firstName,
    required String lastName,
    required String aboutMe,
  }) async {
    _isLoading = true;
    final me = myProfile;
    if (me == null) {
      _errorMessage = "Not my profile";
      notifyListeners();
      return;
    }

    _saving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updated = await UserRepository.updateMyProfile(
        firstName: firstName,
        lastName: lastName,
        aboutMe: aboutMe,
      );

      // IMPORTANT: Controller-State aktualisieren
      _userData = updated; // updated sollte UserMyProfileResponse sein
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _saving = false;
      notifyListeners();
    }
  }
}
