import 'dart:convert';

import 'package:casttime/core/storage/token_storage.dart';
import 'package:casttime/features/auth/domain/model/auth_session.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TokenStorage)
class SecureTokenStorage implements TokenStorage {
  static const _sessionKey = 'auth_session';
  static const _userIdKey = 'userId';
  static const _usernameKey = 'username';
  static const _myProfileUrlKey = 'myProfileUrl';
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  SecureTokenStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  AuthSession? _cachedSession;

  @override
  Future<AuthSession?> readSession() async {
    if (_cachedSession != null) return _cachedSession;

    final raw = await _secureStorage.read(key: _sessionKey);
    if (raw == null) return null;

    final json = jsonDecode(raw) as Map<String, dynamic>;
    _cachedSession = AuthSession(
      userId: json[_userIdKey] as int,
      username: json[_usernameKey] as String,
      myProfileUrl: json[_myProfileUrlKey] as String?,
      tokens: AuthTokens(
        accessToken: json[_accessTokenKey] as String,
        refreshToken: json[_refreshTokenKey] as String,
      ),
    );
    return _cachedSession;
  }

  @override
  Future<void> saveSession(AuthSession authSession) async {
    final json = jsonEncode({
      _userIdKey: authSession.userId,
      _usernameKey: authSession.username,
      _myProfileUrlKey: authSession.myProfileUrl,
      _accessTokenKey: authSession.tokens.accessToken,
      _refreshTokenKey: authSession.tokens.refreshToken,
    });
    await _secureStorage.write(key: _sessionKey, value: json);
    _cachedSession = authSession;
  }

  @override
  Future<void> clearSession() async {
    await _secureStorage.delete(key: _sessionKey);
    _cachedSession = null;
  }
}
