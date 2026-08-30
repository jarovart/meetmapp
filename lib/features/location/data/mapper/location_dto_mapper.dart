import 'package:casttime/features/location/data/dto/response/location_base_response_dto.dart';
import 'package:casttime/features/image/data/mapper/image_dto_mapper.dart';
import 'package:casttime/features/location/domain/model/location.dart';
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
