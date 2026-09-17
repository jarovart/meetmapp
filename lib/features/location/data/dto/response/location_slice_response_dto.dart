import 'package:casttime/features/location/data/dto/response/location_base_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_slice_response_dto.g.dart';

@JsonSerializable()
class LocationSliceResponseDTO {
  final List<LocationBaseResponseDTO> content;
  final bool last;

  LocationSliceResponseDTO({required this.content, required this.last});

  factory LocationSliceResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationSliceResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSliceResponseDTOToJson(this);
}
