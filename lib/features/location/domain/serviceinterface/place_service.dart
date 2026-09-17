import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/place.dart';

abstract interface class PlaceService {
  Future<AppResult<List<Place>>> suggestPlaces(String query);
}
