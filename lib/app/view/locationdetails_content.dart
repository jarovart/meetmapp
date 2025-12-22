import 'package:flutter/material.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';
import 'package:meetmaap/features/locations/logic/location_service.dart';

class LocationDetailsContent extends StatelessWidget {
  final LocationFull location;

  const LocationDetailsContent({required this.location});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Drag-Handle
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

        const SizedBox(height: 12),
        Text(location.title, style: Theme.of(context).textTheme.headlineMedium),

        const SizedBox(height: 12),
        Text(location.description, style: const TextStyle(fontSize: 16)),

        const SizedBox(height: 12),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            Text(location.startDateTime.toString()),
            Text(location.endDateTime.toIso8601String()),
          ],
        ),

        const SizedBox(height: 12),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            Text(location.position.latitude.toString()),
            Text(location.position.longitude.toString()),
          ],
        ),

        const SizedBox(height: 12),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            const Text("Erstellt von"),
            Text(location.createdUsername),
          ],
        ),

        const SizedBox(height: 12),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            const Text("Likes"),
            Text(location.likedUserCount.toString()),
          ],
        ),

        const SizedBox(height: 12),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            const Text("Joined by"),
            Text(location.joinedUserCount.toString()),
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
              /*
              ...location.imageUrls
                  .map((url) => _imageCard(url))
              */
            ],
          ),
        ),
      ],
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
