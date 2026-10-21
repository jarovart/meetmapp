import 'package:json_annotation/json_annotation.dart';

part 'status_response_dto.g.dart';

@JsonSerializable()
class StatusResponseDTO {
  const StatusResponseDTO({
    this.serverVersion,
    required this.serverOnline,
    this.dataBaseOnline,
  });

  final String? serverVersion;
  final bool serverOnline;
  final bool? dataBaseOnline;

  factory StatusResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StatusResponseDTOToJson(this);
}
