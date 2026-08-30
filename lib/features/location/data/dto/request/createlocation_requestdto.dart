import 'package:json_annotation/json_annotation.dart';

part 'createlocation_requestdto.g.dart';

@JsonSerializable()
class CreateLocationRequestDTO {
  final String title;
  final double latitude;
  final double longitude;

  CreateLocationRequestDTO({
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  factory CreateLocationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$CreateLocationRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLocationRequestDTOToJson(this);
}
