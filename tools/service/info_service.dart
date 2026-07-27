import 'package:casttime/app/model/response/status_response.dart';
import 'package:casttime/app/repository/info_repository.dart';
import 'package:casttime/app/service/authentication_service.dart';

class InfoService {
  static Future<StatusResponse> getHealth() async {
    if (await AuthService.isLoggedIn()) {
      return InfoRepository.getFullHealth();
    }
    return InfoRepository.getHealth();
  }
}
