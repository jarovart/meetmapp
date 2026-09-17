import 'package:casttime/core/network/auth_interceptor.dart';
import 'package:casttime/features/location/data/dto/response/location_slice_response_dto.dart';
import 'package:casttime/features/profile/data/dto/response/my_profile_response_dto.dart';
import 'package:casttime/features/profile/data/dto/response/profile_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String? baseUrl}) = _ProfileApi;

  @GET('/api/users/me')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<MyProfileResponseDTO> fetchMyProfile();

  @GET('/api/users/findByUsername')
  Future<ProfileResponseDTO> fetchProfile(@Query("username") String username);

  @GET('/api/users/{username}/locations/created')
  Future<LocationSliceResponseDTO> fetchCreatedLocations(
    @Path("username") String username,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @GET('/api/users/{username}/locations/joined')
  Future<LocationSliceResponseDTO> fetchJoinedLocations(
    @Path("username") String username,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );

  @GET('/api/users/{username}/locations/liked')
  @Extra(<String, Object>{AuthInterceptor.withAuthentication: true})
  Future<LocationSliceResponseDTO> fetchLikedLocations(
    @Path("username") String username,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );
}
