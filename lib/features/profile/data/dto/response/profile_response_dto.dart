import 'package:casttime/features/image/data/dto/image_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response_dto.g.dart';

@JsonSerializable()
class ProfileResponseDTO {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final ImageResponseDTO? profileImage;
  final String aboutMe;
  final int likedLocationCount;
  final int joinedLocationCount;

  ProfileResponseDTO({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.aboutMe,
    required this.likedLocationCount,
    required this.joinedLocationCount,
  });

  factory ProfileResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseDTOToJson(this);
}
