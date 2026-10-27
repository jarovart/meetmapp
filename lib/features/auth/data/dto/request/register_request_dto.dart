import 'package:json_annotation/json_annotation.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDTO {
  const RegisterRequestDTO({
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.languageCode,
  });

  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String languageCode;

  factory RegisterRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestDTOToJson(this);
}
