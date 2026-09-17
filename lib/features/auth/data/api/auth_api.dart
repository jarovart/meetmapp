import 'package:casttime/features/auth/data/dto/login_request_dto.dart';
import 'package:casttime/features/auth/data/dto/login_response_dto.dart';
import 'package:casttime/features/auth/data/dto/refresh_token_request_dto.dart';
import 'package:casttime/features/auth/data/dto/refresh_token_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/api/auth/login')
  Future<LoginResponseDTO> login(@Body() LoginRequestDTO loginRequest);

  @POST('/api/auth/refreshToken')
  Future<RefreshTokenResponseDTO> refreshToken(
    @Body() RefreshTokenRequestDTO request,
  );

  @POST('/api/auth/logout')
  Future<void> logout();
}
