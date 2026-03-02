import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/model/responses/userfull_response.dart';
import 'package:meetmaap/app/repository/user_repository.dart';

class UserService {
  static Future<List<UserBaseResponse>> fetchUsersByQuery(String query) async {
    if (query.isNotEmpty) {
      return UserRepository.fetchUsersByQuery(query);
    }
    return UserRepository.fetchAllUsers();
  }

  static Future<UserFullResponse> fetchFullUserById(int id) async {
    return UserRepository.fetchFullUserById(id);
  }

  static Future<UserFullResponse> fetchFullUserByUserName(int id) async {
    return UserRepository.fetchFullUserById(id);
  }

  static Future<UserFullResponse> fetchFullUser(UserBaseResponse user) async {
    return UserRepository.fetchFullUserById(user.id);
  }

  static Future fetchMyProfile() async {
    return UserRepository.fetchMyProfile();
  }
}
