import 'package:casttime/features/location/data/dto/request/createlocation_requestdto.dart';
import 'package:casttime/features/location/data/dto/response/location_baseresponse_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'locationapi.g.dart';

@RestApi()
abstract class LocationApi {
  factory LocationApi(Dio dio, {String? baseUrl}) = _LocationApi;

  @GET('/api/locations')
  Future<List<LocationBaseResponseDTO>> fetchLocationsInView(
    @Query("minLat") double minLat,
    @Query("maxLat") double maxLat,
    @Query("minLng") double minLng,
    @Query("maxLng") double maxLng,
  );

  @GET('/api/locations/search')
  Future<List<LocationBaseResponseDTO>> searchLocations(
    @Query('query') String query,
  );

  @POST('/api/locations')
  Future<LocationBaseResponseDTO> createLocation(
    @Body() CreateLocationRequestDto request,
  );
}
