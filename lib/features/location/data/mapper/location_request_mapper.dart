import 'package:casttime/features/location/data/dto/request/createlocation_requestdto.dart';
import 'package:casttime/features/location/domain/model/location_detail.dart';

extension LocationToRequestMapper on LocationDetail {
  CreateLocationRequestDTO toCreateRequest() {
    return CreateLocationRequestDTO(
      title: location.title,
      latitude: location.position.latitude,
      longitude: location.position.longitude,
    );
  }
}
