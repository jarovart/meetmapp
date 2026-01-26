import 'package:latlong2/latlong.dart';

class CreateLocationRequest {
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final String thumbnailUrl;
  final List<String> imageUrls;
  final String createdUsername;

  CreateLocationRequest({
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
    required this.thumbnailUrl,
    required this.imageUrls,
    required this.createdUsername,
  });

  Map<String, dynamic> toMap() {
    return {
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
      "createdUsername": createdUsername,
    };
  }

  factory CreateLocationRequest.fromMap(Map<String, dynamic> map) {
    return CreateLocationRequest(
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
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdUsername: map['createdUsername'] as String,
    );
  }
}
