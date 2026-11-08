import 'package:latlong2/latlong.dart';

abstract interface class NavigationService {
  Future<void> openNavigation(LatLng position);
}
