import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request_dto.g.dart';

@JsonSerializable()
class VerifyEmailRequestDTO {
  const VerifyEmailRequestDTO({required this.token});

  final String token;

  factory VerifyEmailRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailRequestDTOToJson(this);
}
