import 'package:json_annotation/json_annotation.dart';

part 'api_error_dto.g.dart';

@JsonSerializable()
class ApiErrorDTO {
  final String code;
  final String message;
  final String? requestId;
  final Map<String, String> fieldErrors;
  final int? cooldownSeconds;

  ApiErrorDTO({
    required this.code,
    required this.message,
    this.requestId,
    this.fieldErrors = const {},
    this.cooldownSeconds,
  });

  factory ApiErrorDTO.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorDTOToJson(this);
}
