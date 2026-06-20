import 'package:latlong2/latlong.dart';
import 'package:casttime/app/model/response/image_response.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';

class LocationFullResponse extends LocationBaseResponse {
  final List<ImageResponse> images;

  LocationFullResponse({
    required super.id,
    required super.title,
    required super.description,
    required super.address,
    required super.creationDateTime,
    required super.startDateTime,
    required super.endDateTime,
    required super.position,
    required super.thumbnailImage,
    required super.createdUserId,
    required super.createdUsername,
    required super.likedUserCount,
    required super.joinedUserCount,
    required super.likedByCurrentUser,
    required super.joinedByCurrentUser,
    required this.images,
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
      "thumbnailImage": thumbnailImage,
      "images": images,
      "createdUserId": createdUserId,
      "createdUsername": createdUsername,
      "likedUserCount": likedUserCount,
      "joinedUserCount": joinedUserCount,
      "likedByCurrentUser": likedByCurrentUser,
      "joinedByCurrentUser": joinedByCurrentUser,
    };
  }

  factory LocationFullResponse.fromMap(Map<String, dynamic> map) {
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
      thumbnailImage: map['thumbnailImage'] != null
          ? ImageResponse.fromMap(map['thumbnailImage'])
          : null,
      images:
          (map['images'] as List<dynamic>?)
              ?.map((e) => ImageResponse.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdUserId: map['createdUserId'] as int,
      createdUsername: map['createdUsername'] as String,
      likedUserCount: map['likedUserCount'] ?? 0,
      joinedUserCount: map['joinedUserCount'] ?? 0,
      likedByCurrentUser: map['likedByCurrentUser'],
      joinedByCurrentUser: map['joinedByCurrentUser'],
    );
  }
}
