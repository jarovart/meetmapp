import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/info/domain/model/app_status.dart';

abstract class InfoService {
  Future<AppResult<AppStatus>> fetchStatus();
}
