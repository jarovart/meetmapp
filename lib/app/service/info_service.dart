import 'package:meetmaap/app/model/response/status_response.dart';
import 'package:meetmaap/app/repository/info_repository.dart';
import 'package:meetmaap/app/service/authentication_service.dart';

class InfoService {
  static Future<StatusResponse> getHealth() async {
    if (await AuthService.isLoggedIn()) {
      return InfoRepository.getFullHealth();
    }
    return InfoRepository.getHealth();
  }
}
