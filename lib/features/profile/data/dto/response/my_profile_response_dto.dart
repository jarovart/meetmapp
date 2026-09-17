import 'package:casttime/features/image/data/dto/image_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_profile_response_dto.g.dart';

@JsonSerializable()
class MyProfileResponseDTO {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final ImageResponseDTO? profileImage;
  final String aboutMe;
  final int likedLocationCount;
  final int joinedLocationCount;
  final String email;
  final DateTime createdAt;
  final int createdLocationCount;

  MyProfileResponseDTO({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.aboutMe,
    required this.likedLocationCount,
    required this.joinedLocationCount,
    required this.email,
    required this.createdAt,
    required this.createdLocationCount,
  });

  factory MyProfileResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MyProfileResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MyProfileResponseDTOToJson(this);
}
