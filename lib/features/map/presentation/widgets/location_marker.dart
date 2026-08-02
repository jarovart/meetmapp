import 'package:casttime/features/location/domain/model/location.dart';
import 'package:flutter/material.dart';

class LocationMarker extends StatelessWidget {
  final Location location;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationMarker({
    super.key,
    required this.location,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.location_on,
        color: isSelected ? Colors.blue : Colors.red,
        size: isSelected ? 40 : 30,
      ),
    );
  }
}
