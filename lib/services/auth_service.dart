import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Anmeldung mit E-Mail & Passwort
  Future<AuthResponse?> signIn(String email, String password) async {
    try {
      final res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return res;
    } on AuthException catch (e) {
      print('⚠️ Auth-Fehler: ${e.message}');
      return null;
    } catch (e) {
      print('❌ Unerwarteter Fehler: $e');
      return null;
    }
  }

  /// Registrierung (E-Mail & Passwort)
  Future<AuthResponse?> signUp(String email, String password) async {
    try {
      final res = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return res;
    } on AuthException catch (e) {
      print('⚠️ Registrierungsfehler: ${e.message}');
      return null;
    } catch (e) {
      print('❌ Unerwarteter Fehler: $e');
      return null;
    }
  }

  /// Abmelden
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    print('🚪 Benutzer abgemeldet');
  }

  /// Aktuelle Session abrufen
  Session? getCurrentSession() {
    return _supabase.auth.currentSession;
  }

  /// Aktuellen Benutzer abrufen
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// Echtzeit-Listener für Auth-Änderungen
  Stream<AuthState> onAuthStateChange() {
    return _supabase.auth.onAuthStateChange;
  }
}
