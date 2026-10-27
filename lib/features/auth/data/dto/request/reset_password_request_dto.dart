import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_dto.g.dart';

@JsonSerializable()
class ResetPasswordRequestDTO {
  final String token;
  final String newPassword;

  const ResetPasswordRequestDTO({
    required this.token,
    required this.newPassword,
  });

  factory ResetPasswordRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestDTOToJson(this);
}
