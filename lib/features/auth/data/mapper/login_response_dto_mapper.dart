import 'package:casttime/features/auth/data/dto/response/login_response_dto.dart';
import 'package:casttime/features/auth/domain/model/auth_session.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';

extension AuthSessionDtoMapper on LoginResponseDTO {
  AuthSession toDomain() {
    return AuthSession(
      userId: userId,
      username: username,
      myProfileUrl: myProfileUrl,
      tokens: AuthTokens(accessToken: token, refreshToken: refreshToken),
    );
  }
}
