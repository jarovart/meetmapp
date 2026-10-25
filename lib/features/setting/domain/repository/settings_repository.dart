import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';

abstract interface class SettingsRepository {
  Future<AppResult<AppSettings>> loadRemote();
  Future<AppResult<AppSettings>> saveRemote(AppSettings settings);
}
