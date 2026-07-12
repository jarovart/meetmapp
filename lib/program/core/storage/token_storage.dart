abstract interface class TokenStorage {
  Future<void> saveAccessToken(String token);
  Future<String?> readAccessToken();
  Future<void> saveRefreshToken(String token);
  Future<String?> readRefreshToken();
  Future<void> clearTokens();
}
