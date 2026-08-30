import 'package:casttime/features/location/data/dto/request/createlocation_requestdto.dart';
import 'package:casttime/features/location/data/dto/response/location_base_response_dto.dart';
import 'package:casttime/features/location/data/dto/response/location_full_response_dto.dart';
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

  @GET('/api/locations/findById')
  Future<LocationFullResponseDTO> fetchFullLocation(@Query("id") int id);

  @GET('/api/locations/search')
  Future<List<LocationBaseResponseDTO>> searchLocations(
    @Query('query') String query,
  );

  @POST('/api/locations')
  Future<LocationBaseResponseDTO> createLocation(
    @Body() CreateLocationRequestDTO request,
  );

  @GET('/api/locations/withinWithTime')
  Future<List<LocationBaseResponseDTO>> fetchLocationsWithDateRange(
    @Query("minLat") double minLat,
    @Query("maxLat") double maxLat,
    @Query("minLng") double minLng,
    @Query("maxLng") double maxLng,
    @Query("rangeStart") String startDate,
    @Query("rangeEnd") String endDate,
  );

  @GET('/api/locations/join')
  Future<void> join(@Query("id") int id);

  @GET('/api/locations/like')
  Future<void> like(@Query("id") int id);

  @GET('/api/locations/unjoin')
  Future<void> unjoin(@Query("id") int id);

  @GET('/api/locations/unlike')
  Future<void> unlike(@Query("id") int id);

  @GET('/api/locations/isJoined')
  Future<bool> isJoined(@Query("id") int id);

  @GET('/api/locations/isLiked')
  Future<bool> isLiked(@Query("id") int id);
}
