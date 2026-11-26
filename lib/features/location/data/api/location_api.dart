import 'dart:convert';

import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/features/location/data/dto/request/create_location_request_dto.dart';
import 'package:casttime/features/location/data/dto/request/update_location_request_dto.dart';
import 'package:casttime/features/location/data/dto/request/update_thumbnail_request_dto.dart';
import 'package:casttime/features/location/data/dto/response/location_base_response_dto.dart';
import 'package:casttime/features/location/data/dto/response/location_full_response_dto.dart';
import 'package:casttime/features/location/data/dto/response/location_slice_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'location_api.g.dart';

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
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<LocationFullResponseDTO> fetchFullLocation(@Query('id') int id);

  @GET('/api/locations/search')
  Future<List<LocationBaseResponseDTO>> searchLocations(
    @Query('query') String query,
  );

  @POST('/api/locations/createLocation')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
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

  @POST('/api/locations/{locationId}/join')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<void> join(@Path('locationId') int locationId);

  @POST('/api/locations/{locationId}/like')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<void> like(@Path('locationId') int locationId);

  @DELETE('/api/locations/{locationId}/unjoin')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<void> unjoin(@Path('locationId') int locationId);

  @DELETE('/api/locations/{locationId}/unlike')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<void> unlike(@Path('locationId') int locationId);

  @GET('/api/locations/joined')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<bool> isJoined(@Path('locationId') int locationId);

  @GET('/api/locations/liked')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<bool> isLiked(@Path('locationId') int locationId);

  @GET('/api/locations/created')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<bool> isCreated(@Path('locationId') int locationId);

  @GET('/api/locations/findByFilter')
  Future<LocationSliceResponseDTO> searchLocationsWithFilter({
    @Query('query') String? query,
    @Query('minLat') required double minLat,
    @Query('maxLat') required double maxLat,
    @Query('minLng') required double minLng,
    @Query('maxLng') required double maxLng,
    @Query('rangeStart') required String rangeStart,
    @Query('rangeEnd') required String rangeEnd,
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @PATCH('/api/locations/{locationId}/thumbnail')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<LocationBaseResponseDTO> patchThumbnail(
    @Path('locationId') int locationId,
    @Body() UpdateThumbnailRequestDTO request,
  );

  @PATCH('/api/locations/{locationId}/thumbnail')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<LocationBaseResponseDTO> updateMyLocation(
    @Path('locationId') int locationId,
    @Body() UpdateThumbnailRequestDTO request,
  );

  @PATCH('/api/locations/{locationId}')
  @MultiPart()
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<LocationFullResponseDTO> updateLocation(
    @Path('locationId') int locationId,
    @Part(name: 'data', contentType: 'application/json')
    UpdateLocationRequestDTO data,
    @Part(name: 'files') List<MultipartFile>? files,
  );

  @GET('/api/users/{username}/locations/joinedList')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<LocationSliceResponseDTO> fetchJoinedLocations(
    @Path('username') String username,
    @Query('page') int page,
    @Query('size') int size,
    @Query('upcoming') bool upcoming,
  );
}
