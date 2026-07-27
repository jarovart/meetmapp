import 'package:latlong2/latlong.dart';

class CreateLocationRequest {
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final LatLng position;
  final String createdUsername;

  CreateLocationRequest({
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
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
      "createdUsername": createdUsername,
    };
  }
}
