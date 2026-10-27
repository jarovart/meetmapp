import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/features/auth/data/dto/request/forgot_password_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/login_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/reset_password_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/verify_email_request_dto.dart';
import 'package:casttime/features/auth/data/dto/response/login_response_dto.dart';
import 'package:casttime/features/auth/data/dto/request/refresh_token_request_dto.dart';
import 'package:casttime/features/auth/data/dto/response/refresh_token_response_dto.dart';
import 'package:casttime/features/auth/data/dto/request/register_request_dto.dart';
import 'package:casttime/features/auth/data/dto/request/send_email_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String? baseUrl}) = _AuthApi;

  @POST('/api/auth/login')
  Future<LoginResponseDTO> login(@Body() LoginRequestDTO loginRequest);

  @POST('/api/auth/refreshToken')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<RefreshTokenResponseDTO> refreshToken(
    @Body() RefreshTokenRequestDTO request,
  );

  @POST('/api/auth/logout')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<void> logout();

  @POST('/api/auth/register')
  Future<void> register(@Body() RegisterRequestDTO registerRequest);

  @POST('/api/auth//resend-verification')
  Future<void> resendVerificationEmail(
    @Body() SendEmailRequestDTO sendEmailRequest,
  );

  @POST('/api/auth/verify')
  Future<void> verifyEmail(@Body() VerifyEmailRequestDTO request);

  @POST('/api/auth/forgot-password')
  Future<void> forgotPassword(@Body() ForgotPasswordRequestDTO request);

  @POST('/api/auth/reset-password')
  Future<void> resetPassword(@Body() ResetPasswordRequestDTO request);
}
