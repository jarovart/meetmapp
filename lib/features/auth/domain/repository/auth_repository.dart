import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';
import 'package:casttime/features/auth/domain/model/auth_session.dart';

abstract interface class AuthRepository {
  Future<AppResult<AuthSession>> login(String username, String password);
  Future<AppResult<AuthTokens>> refreshToken(String refreshToken);
  Future<void> logout();
}
