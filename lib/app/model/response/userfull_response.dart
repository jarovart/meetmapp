import 'package:meetmaap/app/model/response/image_response.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';

class UserFullResponse extends UserBaseResponse {
  final String aboutMe;
  final int likedLocationCount;
  final int joinedLocationCount;

  UserFullResponse({
    required super.id,
    required super.username,
    required super.firstName,
    required super.lastName,
    required super.profileImage,
    required this.aboutMe,
    required this.likedLocationCount,
    required this.joinedLocationCount,
  });

  factory UserFullResponse.fromMap(Map<String, dynamic> map) {
    return UserFullResponse(
      id: map['id'] as int,
      username: map['username'] as String,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profileImage: map['profileImage'] != null
          ? ImageResponse.fromMap(map['profileImage'])
          : null,
      aboutMe: map['aboutMe'] ?? '',
      likedLocationCount: map['likedLocationCount'] ?? 0,
      joinedLocationCount: map['joinedLocationCount'] ?? 0,
    );
  }

  String get getInitials {
    String result = '';

    if (firstName.trim().isNotEmpty) {
      result += firstName.trim()[0];
    }

    if (lastName.trim().isNotEmpty) {
      result += lastName.trim()[0];
    }

    if (result.isEmpty && username.trim().isNotEmpty) {
      result = username.length >= 2
          ? username.substring(0, 2)
          : username.substring(0, 1);
    }

    return result.toUpperCase();
  }
}
