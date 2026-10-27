import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request_dto.g.dart';

@JsonSerializable()
class RefreshTokenRequestDTO {
  final String refreshToken;

  RefreshTokenRequestDTO({required this.refreshToken});

  factory RefreshTokenRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestDTOToJson(this);
}
