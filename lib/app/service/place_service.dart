import 'package:meetmaap/app/model/response/place_response.dart';
import 'package:meetmaap/app/repository/place_repository.dart';

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
