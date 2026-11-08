import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/features/image/data/dto/image_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'image_api.g.dart';

@RestApi()
abstract class ImageApi {
  factory ImageApi(Dio dio, {String? baseUrl}) = _ImageApi;

  @POST('/api/images/me')
  @MultiPart()
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<ImageResponseDTO> uploadProfileImage(
    @Part(name: 'file') MultipartFile file,
  );

  @DELETE('/api/images/me')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<void> deleteProfileImage();

  @POST('/api/images/uploadImages')
  @MultiPart()
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<List<ImageResponseDTO>> uploadLocationImages(
    @Part(name: 'files') List<MultipartFile> files,
    @Part(name: 'locationId') int locationId,
  );
}
