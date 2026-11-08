import 'package:json_annotation/json_annotation.dart';

part 'create_location_request_dto.g.dart';

@JsonSerializable()
class CreateLocationRequestDTO {
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final double latitude;
  final double longitude;
  final String createdUsername;

  CreateLocationRequestDTO({
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.latitude,
    required this.longitude,
    required this.createdUsername,
  });

  factory CreateLocationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateLocationRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLocationRequestDTOToJson(this);
}
