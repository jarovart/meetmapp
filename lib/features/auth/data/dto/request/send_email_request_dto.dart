import 'package:json_annotation/json_annotation.dart';

part 'send_email_request_dto.g.dart';

@JsonSerializable()
class SendEmailRequestDTO {
  const SendEmailRequestDTO({required this.email, required this.languageCode});

  final String email;
  final String languageCode;

  factory SendEmailRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$SendEmailRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SendEmailRequestDTOToJson(this);
}
