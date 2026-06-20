import 'package:flutter/cupertino.dart';
import 'package:casttime/app/model/response/usermyprofile_response.dart';
import 'package:casttime/app/repository/authentication_repository.dart';
import 'package:casttime/app/repository/user_repository.dart';
import 'package:casttime/app/view/util/app_errormessage_mapper.dart';

class AuthService {
  static Future<bool> isLoggedIn() async {
    return await AuthRepository.isLoggedIn();
  }

  static Future<void> login({
    required String username,
    required String password,
  }) async {
    return await AuthRepository.login(username: username, password: password);
  }

  static Future<void> logout() async {
    return await AuthRepository.logout();
  }

  static Future<void> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    return await AuthRepository.register(
      username: username,
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
    );
  }

  static Future<void> verifyEmail(String token) async {
    return await AuthRepository.verifyEmail(token);
  }

  static Future<void> resendVerificationEmail({required String email}) async {
    return await AuthRepository.resendVerificationEmail(email: email);
  }

  static Future<void> forgotPassword({required String email}) async {
    return await AuthRepository.forgotPassword(email: email);
  }

  static Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return await AuthRepository.resetPassword(
      token: token,
      newPassword: newPassword,
    );
  }

  static Future<void> clearCachedMyProfile() async {
    return await AuthRepository.clearCachedMyProfile();
  }

  static Future<void> saveMyProfile(UserMyProfileResponse myProfile) async {
    return await AuthRepository.saveMyProfile(myProfile);
  }

  static Future<String?> getToken() async {
    return await AuthRepository.getToken();
  }

  static Future<String?> getUsername() async {
    return await AuthRepository.getUsername();
  }

  static Future<int?> getUserId() async {
    return await AuthRepository.getUserId();
  }

  static Future<UserMyProfileResponse?> getMyUserProfile() async {
    return await AuthRepository.getMyUserProfile();
  }

  static Future<UserMyProfileResponse?> fetchMyProfile() async {
    try {
      return await UserRepository.fetchMyProfile();
    } catch (e) {
      debugPrint("Error fetching my profile: $e");
      return await AuthRepository.getMyUserProfile();
    }
  }

  static Future<bool> isLoggedInOnServer({
    bool serverReachableOptional = false,
  }) async {
    try {
      await UserRepository.fetchMyProfile();
      return true;
    } catch (e) {
      //Forbidden == usertoken is not valid
      if (AppErrorMapper.isForbiddenException(e)) {
        debugPrint("refreshLogin: serverforbidden");
        return false;
      }

      if (serverReachableOptional &&
          AppErrorMapper.isServerNotReachableException(e)) {
        debugPrint("refreshLogin: serverunreachable");
        return await AuthService.isLoggedIn();
      }
      rethrow;
    }
  }
}
