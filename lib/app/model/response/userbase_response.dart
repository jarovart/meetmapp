import 'package:meetmaap/app/model/response/image_response.dart';

class UserBaseResponse {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final ImageResponse? profileImage;

  UserBaseResponse({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  factory UserBaseResponse.fromMap(Map<String, dynamic> map) {
    return UserBaseResponse(
      id: map['id'] as int,
      username: map['username'] as String,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profileImage: map['profileImage'] != null
          ? ImageResponse.fromMap(map['profileImage'])
          : null,
    );
  }
}
