import 'package:latlong2/latlong.dart';

class LocationBase {
  final String id;
  final String title;
  final String description;
  final String date;
  final LatLng position;
  final String thumbnailUrl;

  LocationBase({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.position,
    required this.thumbnailUrl,
  });

  factory LocationBase.fromMap(Map<String, dynamic> map) {
    return LocationBase(
      id: map['id'].toString(),
      title: map['title'].toString(),
      description: map['description'].toString(),
      date: map['date'].toString(),
      position: map['position'],
      thumbnailUrl: map['thumbnailUrl'].toString(),
    );
  }
}
