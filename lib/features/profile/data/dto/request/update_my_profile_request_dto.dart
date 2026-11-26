import 'package:json_annotation/json_annotation.dart';

part 'update_my_profile_request_dto.g.dart';

@JsonSerializable()
class UpdateMyProfileRequestDTO {
  const UpdateMyProfileRequestDTO({
    required this.firstName,
    required this.lastName,
    required this.aboutMe,
    required this.removeProfileImage,
  });

  final String firstName;
  final String lastName;
  final String aboutMe;
  final bool removeProfileImage;

  Map<String, dynamic> toJson() => _$UpdateMyProfileRequestDTOToJson(this);
}
