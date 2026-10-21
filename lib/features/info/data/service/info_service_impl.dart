import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/info/data/api/info_api.dart';
import 'package:casttime/features/info/data/mapper/status_dto_mapper.dart';
import 'package:casttime/features/info/domain/model/app_status.dart';
import 'package:casttime/features/info/domain/service/info_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: InfoService)
class InfoServiceImpl implements InfoService {
  const InfoServiceImpl(this._api, this._failureMapper);

  final InfoApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<AppStatus>> fetchStatus() async {
    try {
      final dto = await _api.getStatus();
      return Success(dto.toDomain());
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
