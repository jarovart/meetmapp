import 'package:latlong2/latlong.dart';

class LocationBase {
  final int id; //äquivalent zu java long 64bit
  final String title;
  final String description;
  final String address;
  final DateTime creationDateTime;
  final DateTime
  startDateTime; // für ui DateFormat('dd.MM.yyyy HH:mm').format(location.startDateTime)
  ///location.startDateTime.isAfter(rangeStart)
  ///location.endDateTime.isBefore(rangeEnd)
  final DateTime endDateTime;
  final LatLng position;
  final String thumbnailUrl;
  final int createdUserId;
  final String createdUsername;
  final int joinedUserCount;
  final int likedUserCount;

  LocationBase({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.creationDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.position,
    required this.thumbnailUrl,
    required this.createdUserId,
    required this.createdUsername,
    required this.joinedUserCount,
    required this.likedUserCount,
  });

  factory LocationBase.fromMap(Map<String, dynamic> map) {
    return LocationBase(
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
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      createdUserId: map['createdUserId'] as int,
      createdUsername: map['createdUsername'] as String,
      joinedUserCount: map['joinedUserCount'] ?? 0,
      likedUserCount: map['likedUserCount'] ?? 0,
    );
  }

  int getLocationScore() {
    int score = likedUserCount * 3 + joinedUserCount;

    // Bonus: Event läuft gerade
    final now = DateTime.now();
    if (startDateTime.isBefore(now) && endDateTime.isAfter(now)) {
      score += 5;
    }

    // Bonus: Startet bald (< 24h)
    if (startDateTime.difference(now).inHours < 24) {
      score += 2;
    }

    return score;
  }
}
