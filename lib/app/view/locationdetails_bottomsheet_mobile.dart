import 'package:flutter/material.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';
import 'package:meetmaap/features/locations/logic/location_service.dart';
import 'package:meetmaap/app/view/locationdetails_content.dart';

class LocationDetailsBottomSheet extends StatelessWidget {
  final LocationBase locationBase;

  const LocationDetailsBottomSheet({super.key, required this.locationBase});

  // 🔹 Imperativ: öffnet das Sheet
  static Future<void> show(
    BuildContext context, {
    required LocationBase locationBase,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      //showDragHandle: true,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height - 110,
      ),
      builder: (_) => LocationDetailsBottomSheet(locationBase: locationBase),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationFull>(
      future: LocationService.fetchFullLocation(locationBase.id),
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

        return DraggableScrollableSheet(
          snap: true,
          snapSizes: const [0.55, 1.0],
          expand: false,
          initialChildSize: 0.55, // 40% Höhe beim Öffnen
          minChildSize: 0.25, // minimal (nach unten ziehen)
          maxChildSize: 1.0, // 🔥 volle Höhe beim Hochziehen
          builder: (_, scrollController) {
            return LocationDetailsContent(
              location: location,
              scrollController: scrollController,
              dragHandle: true,
            );
          },
        );
      },
    );
  }

  Widget _imageCard({String? url}) {
    const fallBackUrl =
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee";

    return Container(
      width: 300,
      height: 300,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(url ?? fallBackUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
