/// Lightweight placeholder AuthService (no Supabase) so project can run without Supabase.
/// Replace with real implementation when integrating your Spring Boot backend.
library;

sealed class AuthResult {
  const AuthResult();
}

class AuthSuccess extends AuthResult {
  final String message;
  const AuthSuccess(this.message);
}

class AuthFailure extends AuthResult {
  final String message;
  const AuthFailure(this.message);
}

class AuthService {
  Future<AuthResult> signIn(String email, String password) async {
    // Placeholder: always return failure. Replace with real API call.
    return const AuthFailure('Auth not implemented');
  }

  Future<AuthResult> signUp(String email, String password) async {
    return const AuthFailure('Auth not implemented');
  }

  Future<void> signOut() async {}

  // No session/user support in placeholder
  dynamic getCurrentSession() => null;
  dynamic getCurrentUser() => null;
  Stream<dynamic> onAuthStateChange() => const Stream.empty();
}
