import 'package:casttime/features/image/data/dto/image_response_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_full_response_dto.g.dart';

@JsonSerializable()
class LocationFullResponseDTO {
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
  final List<ImageResponseDTO> images;

  LocationFullResponseDTO({
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
    required this.images,
  });

  factory LocationFullResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$LocationFullResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LocationFullResponseDTOToJson(this);
}
