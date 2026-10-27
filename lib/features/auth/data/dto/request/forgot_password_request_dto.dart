import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_dto.g.dart';

@JsonSerializable()
class ForgotPasswordRequestDTO {
  const ForgotPasswordRequestDTO({
    required this.email,
    required this.languageCode,
  });

  final String email;
  final String languageCode;

  factory ForgotPasswordRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestDTOToJson(this);
}
