import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDTO {
  final int userId;
  final String username;
  final String? myProfileUrl;
  final String token;
  final String refreshToken;

  LoginResponseDTO({
    required this.userId,
    required this.username,
    this.myProfileUrl,
    required this.token,
    required this.refreshToken,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}
