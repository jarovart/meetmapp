import 'package:flutter/material.dart';

class LocationsPage extends StatelessWidget {
  final String locationId;
  const LocationsPage({super.key, required this.locationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locations')),
      backgroundColor: Colors.grey,
      body: const Center(child: Text('Hier werden alle Locations angezeigt.')),
    );
  }
}
