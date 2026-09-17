// features/map/presentation/util/location_clusterer.dart
import 'dart:math' as math;

import 'package:casttime/features/location/domain/model/location.dart';
import 'package:latlong2/latlong.dart';

class ClusteredLocation {
  const ClusteredLocation({
    required this.displayLocation,
    required this.members,
  });

  final Location
  displayLocation; // die "Gewinner"-Location, wird an IHRER echten Position gezeigt
  final List<Location>
  members; // alle Locations, die hier zusammengefasst wurden
}

class _PixelPoint {
  const _PixelPoint(this.x, this.y);
  final double x;
  final double y;
}

class _Anchor {
  const _Anchor(this.x, this.y, this.width);
  final double x;
  final double y;
  final double width;
}

class LocationClusterer {
  const LocationClusterer({
    this.markerWidth = 130,
    this.markerHeight = 80,
    this.spacing = 8,
  });

  /// Muss der tatsächlichen Marker-Größe in MapPage entsprechen.
  final double markerWidth;
  final double markerHeight;

  /// Zusätzlicher Sicherheitsabstand in Pixeln.
  final double spacing;

  static const _distance = Distance();

  List<ClusteredLocation> cluster(List<Location> locations, double zoom) {
    if (locations.isEmpty) return const [];

    final sorted = List<Location>.from(locations)
      //..sort((a, b) => _score(b).compareTo(_score(a)));
      ..sort((a, b) {
        final scoreCompare = _score(b).compareTo(_score(a));
        if (scoreCompare != 0) return scoreCompare;
        return a.id.compareTo(b.id); // 👈 stabil bei Gleichstand
      });

    final result = <ClusteredLocation>[];
    final anchors = <_Anchor>[];

    for (final location in sorted) {
      final p = _toPixel(location, zoom);
      final w = _visualWidth(location);

      var absorbed = false;
      for (var i = 0; i < anchors.length; i++) {
        final a = anchors[i];
        final minDx = (w + a.width) / 2 + spacing;
        final minDy = markerHeight + spacing;
        // Rechteck-Überlappung: nur wenn BEIDE Achsen zu nah sind
        if ((p.x - a.x).abs() < minDx && (p.y - a.y).abs() < minDy) {
          result[i].members.add(location);
          absorbed = true;
          break;
        }
      }

      if (!absorbed) {
        result.add(
          ClusteredLocation(displayLocation: location, members: [location]),
        );
        anchors.add(_Anchor(p.x, p.y, w));
      }
    }
    return result;
  }

  _PixelPoint _toPixel(Location location, double zoom) {
    final worldSize = 256 * math.pow(2, zoom).toDouble();
    final lat = location.position.latitude;
    final lng = location.position.longitude;

    final x = (lng + 180) / 360 * worldSize;

    final latRad = lat * math.pi / 180;
    final y =
        (1 - math.log(math.tan(latRad) + 1 / math.cos(latRad)) / math.pi) /
        2 *
        worldSize;

    return _PixelPoint(x, y);
  }

  double _score(Location location, {DateTime? now}) {
    final n = now ?? DateTime.now();

    final popularity =
        math.log(1 + location.likedUserCount) * 2 +
        math.log(1 + location.joinedUserCount) * 3;

    var timeBonus = 0.0;
    if (location.startDateTime.isBefore(n) && location.endDateTime.isAfter(n)) {
      timeBonus += 1.5;
    }
    final hoursToStart = location.startDateTime.difference(n).inHours;
    if (hoursToStart >= 0 && hoursToStart < 24) {
      timeBonus += 0.8;
    }

    return popularity + timeBonus + _paidBoost(location.promotionTier);
  }

  double _paidBoost(int tier) => switch (tier) {
    1 => 1.0,
    2 => 2.0,
    3 => 3.0,
    _ => 0.0,
  };

  double _visualWidth(Location location) {
    // ~6.2px pro Zeichen bei fontSize 11 + 12px Padding, gedeckelt
    final labelWidth = (location.title.length * 6.2 + 12).clamp(40.0, 140.0);
    return math.max(labelWidth, 44); // mind. Pin-Breite
  }

  //old

  Location _pickWinner(List<Location> group) {
    if (group.length == 1) return group.first;
    return group.reduce((a, b) => _score(a) >= _score(b) ? a : b);
  }

  double _score1(Location location, {DateTime? now}) {
    final n = now ?? DateTime.now();

    // Log-Skalierung: Unterschied zwischen 10 und 100 Joins zählt spürbar,
    // Unterschied zwischen 100.000 und 5.000.000 kaum noch zusätzlich.
    final popularity =
        math.log(1 + location.likedUserCount) * 2 +
        math.log(1 + location.joinedUserCount) * 3;

    var timeBonus = 0.0;
    if (location.startDateTime.isBefore(n) && location.endDateTime.isAfter(n)) {
      timeBonus += 1.5; // läuft gerade
    }
    final hoursToStart = location.startDateTime.difference(n).inHours;
    if (hoursToStart >= 0 && hoursToStart < 24) {
      timeBonus += 0.8; // startet bald
    }

    return popularity + timeBonus + _paidBoost(location.promotionTier);
  }

  /// Gedeckelter Bonus fürs Bezahlen – kann bei Gleichstand den Ausschlag geben,
  /// aber niemals echte organische Popularität überstimmen.
  double _paidBoost1(int tier) {
    return switch (tier) {
      1 => 1.0,
      2 => 2.0,
      3 => 3.0,
      _ => 0.0,
    };
  }

  double _metersPerPixel(double latitude, double zoom) {
    final latRad = latitude * math.pi / 180;
    return 156543.03392 * math.cos(latRad) / math.pow(2, zoom);
  }
}
