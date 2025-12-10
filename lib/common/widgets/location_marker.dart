import 'package:flutter/material.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';

class LocationMarker extends StatelessWidget {
  final LocationBase location;
  final bool isSelected;

  const LocationMarker({
    super.key,
    this.isSelected = false,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLocationDialog(context),
      child: asd(context),
    );
  }

  Widget asd(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.all(isSelected ? 6 : 2),
      decoration: BoxDecoration(
        //color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: isSelected ? 4 : 0,
        ),
        boxShadow: [
          if (isSelected)
            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 5,
            ),
        ],
      ),
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
