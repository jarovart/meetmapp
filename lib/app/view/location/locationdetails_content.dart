import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/view/util/gallery_widget.dart';

class LocationDetailsContent extends StatelessWidget {
  final LocationFullResponse location;
  final ScrollController? scrollController;
  final bool dragHandle;

  const LocationDetailsContent({
    required this.location,
    this.scrollController,
    this.dragHandle = false,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    List<String> imageUrls = [];
    if (location.imageUrls.isNotEmpty) {
      imageUrls = [location.thumbnailUrl] + location.imageUrls;
    } else {
      imageUrls = [
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
      ];
    }

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
        Text(location.address, style: const TextStyle(fontSize: 16)),

        const SizedBox(height: 12),
        Wrap(
          spacing: 22,
          runSpacing: 8,
          children: [
            Text("Startzeit: ${formatter.format(location.startDateTime)} Uhr"),
            Text("Endzeit: ${formatter.format(location.endDateTime)} Uhr"),
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
        const SizedBox(height: 24),

        ImageGalleryWidget(imageUrls: imageUrls, dragHandle: dragHandle),
      ],
    );
  }
}
