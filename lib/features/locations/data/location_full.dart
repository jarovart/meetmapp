import 'package:latlong2/latlong.dart';

class LocationFull {
  final String id;
  final String title;
  final String description;
  final String date;
  final String address;
  final LatLng position;
  final String thumbnailUrl;
  final String imageUrl;
  final String user;

  LocationFull({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.address,
    required this.position,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.user,
  });

  factory LocationFull.fromMap(Map<String, dynamic> map) {
    return LocationFull(
      id: map['id'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      date: map['date'].toString(),
      address: map['address'].toString(),
      position: LatLng(map['latitude'], map['longitude']),
      thumbnailUrl: map['thumbnailUrl'].toString(),
      imageUrl: map['imageUrl'].toString(),
      user: map['user'].toString(),
    );
  }
}
