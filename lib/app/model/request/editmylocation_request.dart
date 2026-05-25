import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/request/image_request.dart';

class UpdateMyLocationRequest {
  final int id;
  final String title;
  final String description;
  final String address;
  final LatLng position;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<ImageRequest> imageRequests;

  UpdateMyLocationRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.position,
    required this.startDateTime,
    required this.endDateTime,
    required this.imageRequests,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "address": address,
      "latitude": position.latitude,
      "longitude": position.longitude,
      "startDateTime": startDateTime.toIso8601String(),
      "endDateTime": endDateTime.toIso8601String(),
      'imageRequests': imageRequests.map((e) => e.toOrderMap()).toList(),
    };
  }
}
