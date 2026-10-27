import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';
import 'package:casttime/features/auth/domain/model/auth_session.dart';

abstract interface class AuthRepository {
  Future<AppResult<AuthSession>> login(String username, String password);
  Future<AppResult<AuthTokens>> refreshToken(String refreshToken);
  Future<void> logout();
  Future<AppResult<void>> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String languageCode,
  });
  Future<AppResult<void>> resendVerificationEmail({
    required String email,
    required String languageCode,
  });
  Future<AppResult<void>> verifyEmail(String token);
  Future<AppResult<void>> forgotPassword({
    required String email,
    required String languageCode,
  });
  Future<AppResult<void>> resetPassword({
    required String token,
    required String newPassword,
  });
}
