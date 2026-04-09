import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/app/view/util/gallery_widget.dart';
import 'package:provider/provider.dart';

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
    final location = controller.locationFull ?? controller.locationBase;
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
            isLiked: true,
            isJoined: false,
            likeCount: location.likedUserCount,
            joinCount: location.joinedUserCount,
            onLikeTap: () {
              //  LocationService.toggleLike(location.id);
            },
            onJoinTap: () {
              // toggle join
            },
          ),
        ],
      ),
    );
  }
}

class LocationBottomActions extends StatelessWidget {
  final bool isLiked;
  final bool isJoined;
  final int likeCount;
  final int joinCount;
  final VoidCallback onLikeTap;
  final VoidCallback onJoinTap;

  const LocationBottomActions({
    super.key,
    required this.isLiked,
    required this.isJoined,
    required this.likeCount,
    required this.joinCount,
    required this.onLikeTap,
    required this.onJoinTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationDetailsController>(
      builder: (context, controller, _) {
        final location = controller.locationFull;
        debugPrint(location?.title ?? "errors");
        return SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            //color: const Color.fromARGB(255, 223, 222, 222).withValues(alpha: 0.7),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).scaffoldBackgroundColor.withValues(red: 1, alpha: 0.3),
              border: const Border(top: BorderSide(color: Color(0xFFE0E0E0))),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, -2),
                  color: Color(0x12000000),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child:
                      controller.isLoggedIn && controller.locationFull != null
                      ? OutlinedButton.icon(
                          onPressed: controller.isLoggedIn
                              ? controller.toggleLike
                              : null,
                          icon: Icon(
                            controller.isLiked
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          label: Text('Like · ${controller.likedUserCount}'),
                        )
                      : countInfo(
                          Icons.favorite_border,
                          '${controller.likedUserCount} Likes',
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child:
                      controller.isLoggedIn && controller.locationFull != null
                      ? ElevatedButton.icon(
                          onPressed: controller.isLoggedIn
                              ? controller.toggleJoin
                              : null,
                          icon: Icon(
                            controller.isJoined
                                ? Icons.check_circle
                                : Icons.group_add_outlined,
                          ),
                          label: Text('Join · ${controller.joinedUserCount}'),
                        )
                      : countInfo(
                          Icons.group_outlined,
                          '${controller.joinedUserCount} Beitritte',
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget countInfo(IconData icon, String text) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
