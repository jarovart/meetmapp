// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nominatim_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NominatimResponseDTO _$NominatimResponseDTOFromJson(
  Map<String, dynamic> json,
) => NominatimResponseDTO(
  displayName: json['display_name'] as String?,
  address: json['address'] == null
      ? null
      : NominatimAddressDTO.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NominatimResponseDTOToJson(
  NominatimResponseDTO instance,
) => <String, dynamic>{
  'display_name': instance.displayName,
  'address': instance.address,
};

NominatimAddressDTO _$NominatimAddressDTOFromJson(Map<String, dynamic> json) =>
    NominatimAddressDTO(
      road: json['road'] as String?,
      houseNumber: json['house_number'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      town: json['town'] as String?,
      village: json['village'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$NominatimAddressDTOToJson(
  NominatimAddressDTO instance,
) => <String, dynamic>{
  'road': instance.road,
  'house_number': instance.houseNumber,
  'postcode': instance.postcode,
  'city': instance.city,
  'town': instance.town,
  'village': instance.village,
  'country': instance.country,
};
