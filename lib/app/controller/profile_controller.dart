import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/repository/user_repository.dart';
import 'package:meetmaap/app/service/user_service.dart';

class UserProfileController extends ChangeNotifier {
  bool _isLoaded = false;
  bool _loading = false;
  String? _errorMessage;
  UserFullResponse? _userData;
  int? _loadedUserId;

  bool get isLoading => _loading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null && _errorMessage!.isNotEmpty;

  UserFullResponse? get userData => _userData;

  bool get canEdit => _userData is UserMyProfileResponse;

  UserMyProfileResponse? get myProfile => _userData is UserMyProfileResponse
      ? _userData as UserMyProfileResponse
      : null;

  Future<void> initLoad({required int userId}) async {
    // simple guard gegen doppelte loads
    if (_isLoaded) return;
    _isLoaded = true;
    _loading = true;
    _errorMessage = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLoad1(userId: userId);
    });
  }

  Future<void> initLoad1({required int userId}) async {
    try {
      final isLoggedIn = await AuthRepository.isLoggedIn();

      // Du brauchst irgendeine sichere ID des eingeloggten Users:
      // ideal: AuthRepository.getUserId()
      final int? myUserId = isLoggedIn
          ? await AuthRepository.getUserId()
          : null;

      if (myUserId != null && myUserId == userId) {
        final me = await UserService.fetchMyProfile(); // <-- endpoint /me
        _userData = me;
      } else {
        final other = await UserService.fetchFullUserById(userId);
        _userData = other;
      }
    } catch (e) {
      _errorMessage = e.toString(); // besser: Failure mapping
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  bool _saving = false;
  bool get isSaving => _saving;

  Future<void> updateMyProfile({
    required String firstName,
    required String lastName,
    required String aboutMe,
  }) async {
    _loading = true;
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
      _loading = false;
      _saving = false;
      notifyListeners();
    }
  }

  Future<void> reload() async {
    if (_loadedUserId == null) return;
    await load(userId: _loadedUserId!);
  }

  Future<void> load({required int userId}) async {
    if (_isLoaded) return;

    _isLoaded = true;
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
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoaded = false;
      notifyListeners();
    }
  }
}
