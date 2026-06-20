import 'package:casttime/app/model/response/place_response.dart';
import 'package:casttime/app/repository/place_repository.dart';

class PlaceService {
  static Future<List<PlaceResponse>> suggestPlaces(
    String placeNameQuery,
  ) async {
    if (placeNameQuery.trim().isEmpty) {
      return [];
    }
    return await PlaceRepository.fetchSuggestedPlace(placeNameQuery);
  }
}
