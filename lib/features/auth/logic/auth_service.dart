import 'package:supabase_flutter/supabase_flutter.dart';

/// Ergebnis-Typ für Auth-Aktionen
sealed class AuthResult {
  const AuthResult();
}

class AuthSuccess extends AuthResult {
  final AuthResponse response;
  const AuthSuccess(this.response);
}

class AuthFailure extends AuthResult {
  final String message;
  const AuthFailure(this.message);
}

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Anmeldung mit E-Mail & Passwort
  Future<AuthResult> signIn(String email, String password) async {
    return _handleAuthRequest(() async {
      return await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    });
  }

  /// Registrierung
  Future<AuthResult> signUp(String email, String password) async {
    return _handleAuthRequest(() async {
      return await _supabase.auth.signUp(
        email: email,
        password: password,
      );
    });
  }

  /// Abmelden
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      // Optional: Logging/Monitoring
      rethrow;
    }
  }

  /// Aktuelle Session abrufen
  Session? getCurrentSession() => _supabase.auth.currentSession;

  /// Aktuellen Benutzer abrufen
  User? getCurrentUser() => _supabase.auth.currentUser;

  /// Echtzeit-Listener für Auth-Änderungen
  Stream<AuthState> onAuthStateChange() => _supabase.auth.onAuthStateChange;

  /// Gemeinsames Fehler-Handling für signIn/signUp
  Future<AuthResult> _handleAuthRequest(
      Future<AuthResponse> Function() request,
      ) async {
    try {
      final res = await request();
      return AuthSuccess(res);
    } on AuthException catch (e) {
      return AuthFailure(e.message);
    } catch (e) {
      return AuthFailure("Unerwarteter Fehler: $e");
    }
  }
}
/*
final result = await AuthService().signIn(email, password);

switch (result) {
case AuthSuccess(:final response):
print("✅ Eingeloggt: ${response.user?.email}");
case AuthFailure(:final message):
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text("Fehler: $message")),
);
}*/
