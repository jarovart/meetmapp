import 'package:flutter/material.dart';
import 'package:meetmaap/app/repositories/location_repository.dart';
import 'package:meetmaap/app/model/location_base.dart';
import 'package:meetmaap/app/model/location_full.dart';
import 'package:meetmaap/app/view/locations/locationdetails_content.dart';

class LocationDetailsView extends StatefulWidget {
  final LocationBase locationBase;

  const LocationDetailsView({super.key, required this.locationBase});

  @override
  State<LocationDetailsView> createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {
  late final Future<LocationFull> _future;

  @override
  void initState() {
    super.initState();
    _future = LocationService.fetchFullLocation(widget.locationBase.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationFull>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Text('Fehler beim Laden der Location'),
          );
        }

        final location = snapshot.data!;

        return LocationDetailsContent(location: location);
      },
    );
  }
}
