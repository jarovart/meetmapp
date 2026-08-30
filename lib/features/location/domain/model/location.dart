import 'package:casttime/features/location/domain/model/app_image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location.freezed.dart';

@freezed
abstract class Location with _$Location {
  const factory Location({
    required int id,
    required String title,
    required String description,
    required String address,
    required DateTime creationDateTime,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required LatLng position,
    required int createdUserId,
    required String createdUsername,
    required int likedUserCount,
    required int joinedUserCount,
    AppImage? thumbnailImage,
    bool? likedByCurrentUser,
    bool? joinedByCurrentUser,
  }) = _Location;
}
