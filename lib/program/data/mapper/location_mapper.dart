import 'package:casttime/program/data/dto/createlocation_requestdto.dart';
import 'package:casttime/program/data/dto/location_baseresponse_dto.dart';
import 'package:casttime/program/data/mapper/image_mapper.dart';
import 'package:casttime/program/domain/models/location.dart';
import 'package:latlong2/latlong.dart';

extension LocationDtoMapper on LocationBaseResponseDTO {
  Location toDomain() {
    return Location(
      id: id,
      title: title,
      description: description,
      address: address,
      creationDateTime: creationDateTime,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      position: LatLng(latitude, longitude),
      thumbnailImage: thumbnailImage?.toDomain(),
      createdUserId: createdUserId,
      createdUsername: createdUsername,
      likedUserCount: likedUserCount,
      joinedUserCount: joinedUserCount,
      likedByCurrentUser: likedByCurrentUser,
      joinedByCurrentUser: joinedByCurrentUser,
    );
  }
}

extension CreateLocationRequestDtoMapper on Location {
  CreateLocationRequestDto fromDomain() {
    return CreateLocationRequestDto(
      title: title,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
