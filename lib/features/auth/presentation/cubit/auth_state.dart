// features/auth/presentation/cubit/auth_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    int? userId,
    String? username,
    String? myProfileUrl,
  }) = _AuthState;

  const AuthState._();

  bool get isLoggedIn => status == AuthStatus.authenticated;
}
