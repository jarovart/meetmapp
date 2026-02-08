import 'package:meetmaap/app/model/utils/image_utils.dart';

class UserBaseResponse {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String profileUrl;

  UserBaseResponse({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
  });

  factory UserBaseResponse.fromMap(Map<String, dynamic> map) {
    return UserBaseResponse(
      id: map['id'] as int,
      username: map['username'] as String,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profileUrl: ImageUtils.toAbsolute(map['profileUrl']?.toString() ?? ''),
    );
  }
}
