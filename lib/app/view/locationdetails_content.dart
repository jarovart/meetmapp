import 'package:flutter/material.dart';
import 'package:meetmaap/app/view/imageviewer.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';
import 'package:meetmaap/features/locations/logic/location_service.dart';

class LocationDetailsContent extends StatelessWidget {
  final LocationFull location;
  final ScrollController? scrollController;
  final bool dragHandle;

  const LocationDetailsContent({
    required this.location,
    this.scrollController,
    this.dragHandle = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
      "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
      "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
      "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      controller: scrollController,
      children: [
        if (dragHandle) const SizedBox(height: 8),
        if (dragHandle)
          // Drag-Handle
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
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final url = imageUrls[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => ImageGalleryViewer(
                        imageUrls: imageUrls,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: url,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
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
