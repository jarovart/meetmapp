import 'package:meetmaap/app/model/responses/userbase_response.dart';
import 'package:meetmaap/app/model/utils/image_utils.dart';

class UserFullResponse extends UserBaseResponse {
  final String aboutMe;
  final int likedLocationCount;
  final int joinedLocationCount;

  UserFullResponse({
    required super.id,
    required super.username,
    required super.firstName,
    required super.lastName,
    required super.profileUrl,
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
      profileUrl: ImageUtils.toAbsolute(map['profileUrl']?.toString() ?? ''),
      aboutMe: map['aboutMe'] ?? '',
      likedLocationCount: map['likedLocationCount'] ?? 0,
      joinedLocationCount: map['joinedLocationCount'] ?? 0,
    );
  }
}
