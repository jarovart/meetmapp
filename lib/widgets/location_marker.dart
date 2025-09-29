import 'package:flutter/material.dart';
import '../models/location_data.dart';

class LocationMarker extends StatelessWidget {
  final LocationData location;

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
    return const Icon(
      Icons.location_on,
      color: Colors.red,
      size: 40,
    );
  }

  void _showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => _buildLocationDialog(),
    );
  }

  Widget _buildLocationDialog() {
    return AlertDialog(
      title: Text(location.name),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(location.imageUrl, height: 100),
          const SizedBox(height: 8),
          Text(location.description),
        ],
      ),
    );
  }
}
