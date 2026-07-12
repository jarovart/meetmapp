import 'package:casttime/program/domain/models/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location.freezed.dart';

@freezed
class Location with _$Location {
  final int id;
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final Image? thumbnailImage;
  final int createdUserId;
  final String createdUsername;
  final int likedUserCount;
  final int joinedUserCount;
  final bool? likedByCurrentUser;
  final bool? joinedByCurrentUser;

  Location({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
    required this.thumbnailImage,
    required this.createdUserId,
    required this.createdUsername,
    required this.likedUserCount,
    required this.joinedUserCount,
    required this.likedByCurrentUser,
    required this.joinedByCurrentUser,
  });
}
