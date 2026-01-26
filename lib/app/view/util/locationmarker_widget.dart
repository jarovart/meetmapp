import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';

class LocationMarker extends StatelessWidget {
  final LocationBaseResponse location;
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
