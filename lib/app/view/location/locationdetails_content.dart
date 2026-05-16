import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/app/view/util/gallery_widget.dart';
import 'package:meetmaap/app/view/util/locationbottomaction.dart';

class LocationDetailsContent extends StatelessWidget {
  final LocationDetailsController controller;
  final ScrollController? scrollController;
  final bool dragHandle;

  const LocationDetailsContent({
    required this.controller,
    this.scrollController,
    this.dragHandle = false,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    final location = controller.location;
    List<String> imageUrls = controller.imageUrls;

    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: ListView(
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
                if (controller.hasError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      controller.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        location.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),

                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      onPressed: () async => context.push(
                        RouteConfig.locationUrl,
                        extra: controller,
                      ),
                      label: const Text("Open"),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  location.description,
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),
                Text(location.address, style: const TextStyle(fontSize: 16)),

                const SizedBox(height: 12),
                Wrap(
                  spacing: 22,
                  runSpacing: 8,
                  children: [
                    Text(
                      "Startzeit: ${formatter.format(location.startDateTime)} Uhr",
                    ),
                    Text(
                      "Endzeit: ${formatter.format(location.endDateTime)} Uhr",
                    ),
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

                /*const SizedBox(height: 12),
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
                */
                // Bilder
                const SizedBox(height: 24),

                ImageGalleryWidget(
                  imageUrls: imageUrls,
                  dragHandle: dragHandle,
                ),
              ],
            ),
          ),

          LocationBottomActions(
            isLikeJoinAble: controller.isLikeJoinAble,
            isLiked: controller.isLiked,
            isJoined: controller.isJoined,
            likeCount: controller.likedUserCount,
            joinCount: controller.joinedUserCount,
            onLikeTap: controller.toggleLike,
            onJoinTap: controller.toggleJoin,
          ),
        ],
      ),
    );
  }
}
