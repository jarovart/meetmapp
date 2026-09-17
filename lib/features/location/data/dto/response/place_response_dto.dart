import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_response_dto.g.dart';

@JsonSerializable()
class PlaceResponseDTO {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final bool existedPlace;

  PlaceResponseDTO({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.existedPlace,
  });

  factory PlaceResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PlaceResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceResponseDTOToJson(this);
}
