import 'package:casttime/features/auth/data/dto/response/refresh_token_response_dto.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';

extension RefreshResponseDtoMapper on RefreshTokenResponseDTO {
  AuthTokens toDomain() {
    return AuthTokens(accessToken: token, refreshToken: refreshToken);
  }
}
