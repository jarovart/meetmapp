import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/utils/image_utils.dart';

class LocationFullResponse extends LocationBaseResponse {
  final List<String> imageUrls;

  LocationFullResponse({
    required super.id,
    required super.title,
    required super.description,
    required super.address,
    required super.creationDateTime,
    required super.startDateTime,
    required super.endDateTime,
    required super.position,
    required super.thumbnailUrl,
    required super.createdUserId,
    required super.createdUsername,
    required super.joinedUserCount,
    required super.likedUserCount,
    required this.imageUrls,
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
        ? ImageUtils.toAbsolute(rawImage)
        : '';
    final imageUrls = rawImages
        .whereType<String>()
        .map(ImageUtils.toAbsolute)
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
