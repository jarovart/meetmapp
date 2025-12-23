import 'package:latlong2/latlong.dart';

class LocationFull {
  final int id;
  final String title;
  final String description;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final String thumbnailUrl;
  final String imageUrl;
  //final List<String> imageUrls;
  final int createdUserId;
  final String createdUsername;
  final int joinedUserCount;
  final int likedUserCount;

  LocationFull({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.createdUserId,
    required this.createdUsername,
    required this.joinedUserCount,
    required this.likedUserCount,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "creationDateTime": creationDateTime.toIso8601String(),
      "startDateTime": startDateTime.toIso8601String(),
      "endDateTime": endDateTime.toIso8601String(),
      "latitude": position.latitude,
      "longitude": position.longitude,
      "thumbnailUrl": thumbnailUrl,
      "imageUrl": imageUrl,
      "createdUserId": createdUserId,
      "createdUsername": createdUsername,
      "joinedUserCount": joinedUserCount,
      "likedUserCount": likedUserCount,
    };
  }

  factory LocationFull.fromMap(Map<String, dynamic> map) {
    return LocationFull(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] ?? '',
      creationDateTime: DateTime.parse(map['creationDateTime']),
      startDateTime: DateTime.parse(map['startDateTime']),
      endDateTime: DateTime.parse(map['endDateTime']),
      position: LatLng(
        (map['latitude'] as num).toDouble(),
        (map['longitude'] as num).toDouble(),
      ),
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      //imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdUserId: map['createdUserId'] as int,
      createdUsername: map['createdUsername'] as String,
      joinedUserCount: map['joinedUserCount'] ?? 0,
      likedUserCount: map['likedUserCount'] ?? 0,
    );
  }
}
