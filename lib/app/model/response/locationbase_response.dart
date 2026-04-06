import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/response/image_response.dart';

class LocationBaseResponse {
  final int id;
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final ImageResponse? thumbnailImage;
  final int createdUserId;
  final String createdUsername;
  final int likedUserCount;
  final int joinedUserCount;
  final bool? likedByCurrentUser;
  final bool? joinedByCurrentUser;

  LocationBaseResponse({
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

  factory LocationBaseResponse.fromMap(Map<String, dynamic> map) {
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
      thumbnailImage: map['thumbnailImage'] != null
          ? ImageResponse.fromMap(map['thumbnailImage'])
          : null,
      createdUserId: map['createdUserId'] as int,
      createdUsername: map['createdUsername'] as String,
      likedUserCount: map['likedUserCount'] ?? 0,
      joinedUserCount: map['joinedUserCount'] ?? 0,
      likedByCurrentUser: map['likedByCurrentUser'],
      joinedByCurrentUser: map['joinedByCurrentUser'],
    );
  }
}
