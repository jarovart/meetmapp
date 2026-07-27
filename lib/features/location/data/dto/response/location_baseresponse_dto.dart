import 'package:casttime/features/location/data/dto/response/image_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_baseresponse_dto.g.dart';

@JsonSerializable()
class LocationBaseResponseDTO {
  final int id;
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final double latitude;
  final double longitude;
  final ImageResponseDTO? thumbnailImage;
  final int createdUserId;
  final String createdUsername;
  final int likedUserCount;
  final int joinedUserCount;
  final bool? likedByCurrentUser;
  final bool? joinedByCurrentUser;

  LocationBaseResponseDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.latitude,
    required this.longitude,
    required this.thumbnailImage,
    required this.createdUserId,
    required this.createdUsername,
    required this.likedUserCount,
    required this.joinedUserCount,
    required this.likedByCurrentUser,
    required this.joinedByCurrentUser,
  });

  factory LocationBaseResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationBaseResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LocationBaseResponseDTOToJson(this);
}
