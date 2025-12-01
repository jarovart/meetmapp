import 'package:flutter/material.dart';
import '../../features/locations/data/location_base.dart';

class LocationMarker extends StatelessWidget {
  final LocationBase location;

  const LocationMarker({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLocationDialog(context),
      child: _buildMarkerIcon(),
    );
  }

  /// ---------- UI-Aufteilung ----------

  Widget _buildMarkerIcon() {
    return const Icon(Icons.location_on, color: Colors.red, size: 40);
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => _buildLocationDialog());
  }

  Widget _buildLocationDialog() {
    return AlertDialog(
      title: Text(location.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(location.thumbnailUrl, height: 100),
          const SizedBox(height: 8),
          Text(location.description),
        ],
      ),
    );
  }
}
