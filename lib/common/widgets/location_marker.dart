import 'package:flutter/material.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';

class LocationMarker extends StatelessWidget {
  final LocationBase location;
  final bool isSelected;
  final VoidCallback? onTapCallback;

  const LocationMarker({
    super.key,
    this.isSelected = false,
    required this.location,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTapCallback != null) onTapCallback!();
        if (!isSelected) _showLocationDialog(context);
      },
      child: _buildMarkerIcon(),
    );
  }

  /// ---------- UI-Aufteilung ----------
  Widget _buildMarkerIcon() {
    return Icon(
      Icons.location_on,
      color: isSelected ? Colors.blue : Colors.red,
      size: isSelected ? 40 : 30,
    );
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
