import 'package:casttime/features/auth/domain/model/auth_session.dart';

abstract interface class TokenStorage {
  Future<AuthSession?> readSession();
  Future<void> saveSession(AuthSession authSession);
  Future<void> clearSession();
}
