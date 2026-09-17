import 'package:casttime/features/location/data/dto/response/place_response_dto.dart';
import 'package:casttime/features/location/domain/model/place.dart';
import 'package:latlong2/latlong.dart';

extension PlaceDtoMapper on PlaceResponseDTO {
  Place toDomain() {
    return Place(
      name: name,
      position: LatLng(latitude, longitude),
      existedPlace: existedPlace,
    );
  }
}
