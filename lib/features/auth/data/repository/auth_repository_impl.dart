import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/data/api/auth_api.dart';
import 'package:casttime/features/auth/data/dto/login_request_dto.dart';
import 'package:casttime/features/auth/data/dto/refresh_token_request_dto.dart';
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

  Future<AppResult<Domain>> _execute<Dto, Domain>({
    required Future<Dto> Function() request,
    required Domain Function(Dto dto) map,
  }) async {
    try {
      final dto = await request();
      debugPrint("artem: $dto");
      return Success(map(dto));
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
