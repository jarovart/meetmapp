import 'package:casttime/core/failure/api_failure_mapper.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/setting/data/api/settings_api.dart';
import 'package:casttime/features/setting/data/mapper/app_settings_to_request_mapper.dart';
import 'package:casttime/features/setting/data/mapper/settings_response_dto_mapper.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';
import 'package:casttime/features/setting/domain/repository/settings_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl(this._api, this._failureMapper);

  final SettingsApi _api;
  final ApiFailureMapper _failureMapper;

  @override
  Future<AppResult<AppSettings>> loadRemote() async {
    try {
      final dto = await _api.getMySettings();
      return Success(dto.toDomain());
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }

  @override
  Future<AppResult<AppSettings>> saveRemote(AppSettings settings) async {
    try {
      final dto = await _api.saveMySettings(settings.toRequestDTO());
      return Success(dto.toDomain());
    } catch (error, stackTrace) {
      return Failure(_failureMapper.map(error, stackTrace));
    }
  }
}
