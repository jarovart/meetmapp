import 'package:json_annotation/json_annotation.dart';

part 'createlocation_requestdto.g.dart';

@JsonSerializable()
class CreateLocationRequestDto {
  final String title;
  final double latitude;
  final double longitude;

  CreateLocationRequestDto({
    required this.title,
    required this.latitude,
    required this.longitude,
  });

  factory CreateLocationRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateLocationRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateLocationRequestDtoToJson(this);
}
