import 'package:casttime/features/image/data/mapper/image_dto_mapper.dart';
import 'package:casttime/features/profile/data/dto/response/my_profile_response_dto.dart';
import 'package:casttime/features/profile/domain/model/user_profile.dart';

extension MyProfileDtoMapper on MyProfileResponseDTO {
  UserProfile toDomain() {
    return UserProfile(
      id: id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      profileImage: profileImage?.toDomain(),
      aboutMe: aboutMe,
      likedLocationCount: likedLocationCount,
      joinedLocationCount: joinedLocationCount,
      email: email,
      createdAt: createdAt,
      createdLocationCount: createdLocationCount,
    );
  }
}
