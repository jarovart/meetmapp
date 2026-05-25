import 'package:latlong2/latlong.dart';

class EditMyLocationRequest {
  final int id;
  final String title;
  final String description;
  final String address;
  final LatLng position;
  final DateTime startDateTime;
  final DateTime endDateTime;
  //List<ImageOrderItem> imageOrder

  EditMyLocationRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.position,
    required this.startDateTime,
    required this.endDateTime,
    //required this.imageOrder,
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
    };
  }
}
