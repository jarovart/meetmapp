import 'package:casttime/features/auth/domain/model/auth_tokens.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required int userId,
    required String username,
    required String? myProfileUrl,
    required AuthTokens tokens,
  }) = _AuthSession;
}
