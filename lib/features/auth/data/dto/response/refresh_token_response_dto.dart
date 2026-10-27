import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_response_dto.g.dart';

@JsonSerializable()
class RefreshTokenResponseDTO {
  final String token;
  final String refreshToken;

  RefreshTokenResponseDTO({required this.token, required this.refreshToken});

  factory RefreshTokenResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseDTOToJson(this);
}
