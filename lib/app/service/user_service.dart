import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/repository/user_repository.dart';

class UserService {
  static Future<List<UserBaseResponse>> fetchUsersByQuery(String query) async {
    if (query.isNotEmpty) {
      return UserRepository.fetchUsersByQuery(query);
    }
    return UserRepository.fetchAllUsers();
  }
}
