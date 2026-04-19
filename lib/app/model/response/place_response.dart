import 'package:latlong2/latlong.dart';

class PlaceResponse {
  final int id;
  final String name;
  final LatLng position;
  final bool existedPlace;

  PlaceResponse({
    required this.id,
    required this.name,
    required this.position,
    required this.existedPlace,
  });

  factory PlaceResponse.fromMap(Map<String, dynamic> map) {
    return PlaceResponse(
      id: map['id'] as int,
      name: map['name'] as String,
      position: LatLng(
        (map['latitude'] as num).toDouble(),
        (map['longitude'] as num).toDouble(),
      ),
      existedPlace: map['existedPlace'] as bool? ?? false,
    );
  }
}
