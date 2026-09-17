import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/model/place.dart';
import 'package:casttime/features/location/domain/repositoryinterface/place_repository.dart';
import 'package:casttime/features/location/domain/serviceinterface/place_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PlaceService)
class PlaceServiceImpl implements PlaceService {
  final PlaceRepository repository;

  PlaceServiceImpl(this.repository);

  @override
  Future<AppResult<List<Place>>> suggestPlaces(String query) async {
    return await repository.suggestPlaces(query);
  }
}
