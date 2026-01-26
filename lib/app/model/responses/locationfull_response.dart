import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/utils/location_utils.dart';

class LocationFullResponse {
  final int id;
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final String thumbnailUrl;
  final List<String> imageUrls;
  final int createdUserId;
  final String createdUsername;
  final int joinedUserCount;
  final int likedUserCount;

  LocationFullResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
    required this.thumbnailUrl,
    required this.imageUrls,
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
      "address": address,
      "creationDateTime": creationDateTime.toIso8601String(),
      "startDateTime": startDateTime.toIso8601String(),
      "endDateTime": endDateTime.toIso8601String(),
      "latitude": position.latitude,
      "longitude": position.longitude,
      "thumbnailUrl": thumbnailUrl,
      "imageUrls": imageUrls,
      "createdUserId": createdUserId,
      "createdUsername": createdUsername,
      "joinedUserCount": joinedUserCount,
      "likedUserCount": likedUserCount,
    };
  }

  factory LocationFullResponse.fromMap(Map<String, dynamic> map) {
    final rawImage = map['thumbnailUrl'] ?? '';
    final rawImages = (map['imageUrls'] as List?) ?? [];

    final thumbnailUrl = rawImage is String
        ? LocationUtils.toAbsolute(rawImage)
        : '';
    final imageUrls = rawImages
        .whereType<String>()
        .map(LocationUtils.toAbsolute)
        .toList();

    return LocationFullResponse(
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
      //imageUrl: map['imageUrl'] ?? '',
      //imageUrls: List<String>.from(map['imageUrls'] ?? []),
      imageUrls: imageUrls,
      createdUserId: map['createdUserId'] as int,
      createdUsername: map['createdUsername'] as String,
      joinedUserCount: map['joinedUserCount'] ?? 0,
      likedUserCount: map['likedUserCount'] ?? 0,
    );
  }
}
