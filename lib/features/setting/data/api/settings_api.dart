import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/features/setting/data/dto/request/settings_request_dto.dart';
import 'package:casttime/features/setting/data/dto/response/settings_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'settings_api.g.dart';

@RestApi()
abstract class SettingsApi {
  factory SettingsApi(Dio dio, {String? baseUrl}) = _SettingsApi;

  @GET('/api/settings/me')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<SettingsResponseDTO> getMySettings();

  @PUT('/api/settings/me')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<SettingsResponseDTO> saveMySettings(
    @Body() SettingsRequestDTO request,
  );
}
