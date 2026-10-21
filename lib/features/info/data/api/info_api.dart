import 'package:casttime/features/info/data/dto/status_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'info_api.g.dart';

@RestApi()
abstract class InfoApi {
  factory InfoApi(Dio dio, {String? baseUrl}) = _InfoApi;

  @GET('/api/info/status')
  Future<StatusResponseDTO> getStatus();
}
