import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/utils/image_utils.dart';

class LocationBaseResponse {
  final int id;
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final String thumbnailUrl;
  final int createdUserId;
  final String createdUsername;
  final int joinedUserCount;
  final int likedUserCount;

  LocationBaseResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
    required this.thumbnailUrl,
    required this.createdUserId,
    required this.createdUsername,
    required this.joinedUserCount,
    required this.likedUserCount,
  });

  factory LocationBaseResponse.fromMap(Map<String, dynamic> map) {
    final rawImage = map['thumbnailUrl'] ?? '';

    final thumbnailUrl = rawImage is String
        ? ImageUtils.toAbsolute(rawImage)
        : '';

    return LocationBaseResponse(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] ?? '',
      address: map['address'] ?? '',
      creationDateTime: DateTime.parse(map['creationDateTime']),
      startDateTime: DateTime.parse(map['startDateTime']),
      endDateTime: DateTime.parse(map['endDateTime']),
      position: LatLng(
        (map['latitude'] as num).toDouble(),
        (map['longitude'] as num).toDouble(),
      ),
      thumbnailUrl: thumbnailUrl,
      createdUserId: map['createdUserId'] as int,
      createdUsername: map['createdUsername'] as String,
      joinedUserCount: map['joinedUserCount'] ?? 0,
      likedUserCount: map['likedUserCount'] ?? 0,
    );
  }
}
