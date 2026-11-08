// features/location/data/api/geocoding_api.dart
import 'package:casttime/features/location/data/dto/response/nominatim_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'geocoding_api.g.dart';

@RestApi(baseUrl: 'https://nominatim.openstreetmap.org')
abstract class GeocodingApi {
  factory GeocodingApi(Dio dio, {String? baseUrl}) = _GeocodingApi;

  @GET('/reverse')
  Future<NominatimResponseDTO> reverseGeocode(
    @Query('lat') double lat,
    @Query('lon') double lon, {
    @Query('format') String format = 'jsonv2',
    @Query('addressdetails') int addressDetails = 1,
  });
}
