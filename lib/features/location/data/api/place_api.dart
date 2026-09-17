import 'package:casttime/features/location/data/dto/response/place_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'place_api.g.dart';

@RestApi()
abstract class PlaceApi {
  factory PlaceApi(Dio dio, {String? baseUrl}) = _PlaceApi;

  @GET('/api/places')
  Future<List<PlaceResponseDTO>> suggestPlaces(@Query("query") String query);
}
