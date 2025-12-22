import 'package:flutter/material.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';
import 'package:meetmaap/features/locations/logic/location_service.dart';

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
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                // optionaler Drag-Handle
                const SizedBox(height: 8),
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  location.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  location.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 22, // horizontaler Abstand
                  runSpacing: 8,
                  children: [
                    Text(
                      location.startDateTime.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(width: 22),
                    Text(
                      location.endDateTime.toIso8601String(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 22, // horizontaler Abstand
                  runSpacing: 8,
                  children: [
                    Text(
                      location.position.latitude.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(width: 22),
                    Text(
                      location.position.longitude.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 22, // horizontaler Abstand
                  runSpacing: 8,
                  children: [
                    Text("Erstellt von ", style: const TextStyle(fontSize: 16)),
                    Text(
                      location.createdUsername,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 22, // horizontaler Abstand
                  runSpacing: 8,
                  children: [
                    Text("Likes: ", style: const TextStyle(fontSize: 16)),
                    Text(
                      location.likedUserCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 22, // horizontaler Abstand
                  runSpacing: 8,
                  children: [
                    Text("Joined by ", style: const TextStyle(fontSize: 16)),
                    Text(
                      location.joinedUserCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                // Bilder
                const SizedBox(height: 24),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _imageCard(),
                      _imageCard(),
                      _imageCard(),
                      _imageCard(),

                      /*location.imageUrls
                        .map((url) => _imageCard(url))
                        .toList(),*/
                    ],
                  ),
                ),
              ],
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
