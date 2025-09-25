import 'package:latlong2/latlong.dart';

class LocationData {
  final String name;
  final String description;
  final String imageUrl;
  final LatLng position;

  LocationData({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.position,
  });
}
