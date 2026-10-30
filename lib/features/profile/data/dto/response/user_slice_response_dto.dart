import 'package:casttime/features/profile/data/dto/response/profile_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_slice_response_dto.g.dart';

@JsonSerializable()
class UserSliceResponseDTO {
  const UserSliceResponseDTO({required this.content, required this.last});

  final List<ProfileResponseDTO> content;
  final bool last;

  factory UserSliceResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UserSliceResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserSliceResponseDTOToJson(this);
}
