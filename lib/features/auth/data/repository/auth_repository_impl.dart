import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/data/api/auth_api.dart';
import 'package:casttime/features/auth/data/dto/request/forgot_password_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/login_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/refresh_token_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/register_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/reset_password_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/send_email_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/verify_email_request_dto.dart';
import 'package:casttime/features/auth/data/mapper/login_response_dto_mapper.dart';
import 'package:casttime/features/auth/data/mapper/refresh_token_response_dto_mapper.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';
import 'package:casttime/features/auth/domain/model/auth_session.dart';
import 'package:casttime/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._api, this._failureMapper);

  final AuthApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<AuthSession>> login(String username, String password) async {
    return _execute(
      request: () =>
          _api.login(LoginRequestDTO(username: username, password: password)),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<AppResult<AuthTokens>> refreshToken(String refreshToken) async {
    return _execute(
      request: () =>
          _api.refreshToken(RefreshTokenRequestDTO(refreshToken: refreshToken)),
      map: (dto) => dto.toDomain(),
    );
  }

  @override
  Future<void> logout() async {
    try {
      await _api.logout();
      debugPrint("logout success");
    } catch (_) {
      debugPrint("logout failed");
    }
  }

  @override
  Future<AppResult<void>> register({
    required String username,
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String languageCode,
  }) async {
    return _execute(
      request: () => _api.register(
        RegisterRequestDTO(
          username: username,
          firstname: firstname,
          lastname: lastname,
          email: email,
          password: password,
          languageCode: languageCode,
        ),
      ),
      map: (_) => {},
    );
  }

  @override
  Future<AppResult<void>> resendVerificationEmail({
    required String email,
    required String languageCode,
  }) async {
    return _execute(
      request: () => _api.resendVerificationEmail(
        SendEmailRequestDTO(email: email, languageCode: languageCode),
      ),
      map: (_) => {},
    );
  }

  @override
  Future<AppResult<void>> verifyEmail(String token) async {
    return _execute(
      request: () => _api.verifyEmail(VerifyEmailRequestDTO(token: token)),
      map: (_) => {},
    );
  }

  @override
  Future<AppResult<void>> forgotPassword({
    required String email,
    required String languageCode,
  }) async {
    return _execute(
      request: () => _api.forgotPassword(
        ForgotPasswordRequestDTO(email: email, languageCode: languageCode),
      ),
      map: (_) => {},
    );
  }

  @override
  Future<AppResult<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    return _execute(
      request: () => _api.resetPassword(
        ResetPasswordRequestDTO(token: token, newPassword: newPassword),
      ),
      map: (_) => {},
    );
  }

  Future<AppResult<Domain>> _execute<Dto, Domain>({
    required Future<Dto> Function() request,
    required Domain Function(Dto dto) map,
  }) async {
    try {
      final dto = await request();
      return Success(map(dto));
    } catch (error, stackTrace) {
      debugPrint('auth repository error: $error');
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
