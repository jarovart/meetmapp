import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/data/api/place_api.dart';
import 'package:casttime/features/location/data/mapper/place_dto_mapper.dart';
import 'package:casttime/features/location/domain/model/place.dart';
import 'package:casttime/features/location/domain/repositoryinterface/place_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PlaceRepository)
class PlaceRepositoryImpl implements PlaceRepository {
  PlaceRepositoryImpl(this._api, this._failureMapper);

  final PlaceApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<List<Place>>> suggestPlaces(String query) async {
    return _execute(
      request: () => _api.suggestPlaces(query),
      map: (dtos) => dtos.map((dto) => dto.toDomain()).toList(),
    );
  }

  Future<AppResult<Domain>> _execute<Dto, Domain>({
    required Future<Dto> Function() request,
    required Domain Function(Dto dto) map,
  }) async {
    try {
      final dto = await request();
      return Success(map(dto));
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
