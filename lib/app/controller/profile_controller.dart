import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/model/responses/usermyprofile_response.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/service/user_service.dart';

class UserProfileController extends ChangeNotifier {
  bool _isLoaded = false;
  bool _loading = false;
  String? _error;
  UserFullResponse? _userData;

  bool get isLoading => _loading;
  String? get errorMessage => _error;
  bool get hasError => _error != null && _error!.isNotEmpty;

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
    _error = null;

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
      _error = e.toString(); // besser: Failure mapping
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
