enum LocationType { created, joined, liked }

extension LocationTypeExtension on LocationType {
  String get path {
    switch (this) {
      case LocationType.created:
        return 'created';
      case LocationType.joined:
        return 'joined';
      case LocationType.liked:
        return 'liked';
    }
  }
}
