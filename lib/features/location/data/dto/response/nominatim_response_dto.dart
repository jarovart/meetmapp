import 'package:json_annotation/json_annotation.dart';

part 'nominatim_response_dto.g.dart';

@JsonSerializable()
class NominatimResponseDTO {
  const NominatimResponseDTO({this.displayName, this.address});

  @JsonKey(name: 'display_name')
  final String? displayName;

  final NominatimAddressDTO? address;

  factory NominatimResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$NominatimResponseDTOFromJson(json);
}

@JsonSerializable()
class NominatimAddressDTO {
  const NominatimAddressDTO({
    this.road,
    this.houseNumber,
    this.postcode,
    this.city,
    this.town,
    this.village,
    this.country,
  });

  final String? road;

  @JsonKey(name: 'house_number')
  final String? houseNumber;

  final String? postcode;
  final String? city;
  final String? town;
  final String? village;
  final String? country;

  factory NominatimAddressDTO.fromJson(Map<String, dynamic> json) =>
      _$NominatimAddressDTOFromJson(json);
}
