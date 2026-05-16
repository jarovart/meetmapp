import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationService {
  static Future<void> openNavigation(LatLng position) async {
    final lat = position.latitude;
    final lng = position.longitude;

    final googleNavigationUri = Uri.parse(
      'google.navigation:q=$lat,$lng&mode=d',
    );

    final googleMapsWebUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
    );

    if (await canLaunchUrl(googleNavigationUri)) {
      await launchUrl(
        googleNavigationUri,
        mode: LaunchMode.externalApplication,
      );
      return;
    }

    await launchUrl(googleMapsWebUri, mode: LaunchMode.externalApplication);
  }
}
