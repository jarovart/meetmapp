import 'package:flutter/material.dart';
import '../models/location_data.dart';

class LocationMarker extends StatelessWidget {
  final LocationData location;

  const LocationMarker({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(location.name),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(location.imageUrl, height: 100),
                const SizedBox(height: 8),
                Text(location.description),
              ],
            ),
          ),
        );
      },
      child: const Icon(
        Icons.location_on,
        color: Colors.red,
        size: 40,
      ),
    );
  }
}
