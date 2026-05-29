import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/config/app_config.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/app/view/util/InfoRow.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/app/view/util/gallery_widget.dart';
import 'package:meetmaap/app/view/util/imageviewer_widget.dart';
import 'package:meetmaap/app/view/util/infocard.dart';
import 'package:meetmaap/app/view/util/locationbottomaction.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class LocationDetailPage extends StatelessWidget {
  const LocationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LocationDetailsController>();
    final l10n = context.l10n;

    if (!controller.hasLocation) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.location)),
        body: Center(child: Text(l10n.locationCouldNotBeLoaded)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: true,
        actions: [
          if (controller.canEdit)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: OutlinedButton.icon(
                onPressed: () async {
                  final result = await context.push<bool>(
                    RouteConfig.getLocationEditUrl(controller.locationFull!.id),
                    extra: controller.locationFull,
                  );
                  if (result == true) {
                    controller.reload();
                  }
                },
                label: Text(l10n.edit),
                icon: const Icon(Icons.edit_attributes_outlined),
              ),
            ),
        ],
      ),
      body: _buildBody(context, controller),
    );
  }

  Widget _buildBody(
    BuildContext context,
    LocationDetailsController controller,
  ) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final l10n = context.l10n;

    if (controller.hasError) {
      return Center(
        child: Text(
          AppErrorMapper.toUserMessage(
            controller.error!,
            l10n,
            fallback: l10n.locationCouldNotBeLoaded,
          ),
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    final location = controller.location;
    final imageUrls = controller.imageUrls;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 400,
                    child: GestureDetector(
                      onTap: imageUrls.isEmpty
                          ? null
                          : () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (_, _, _) => ImageGalleryViewer(
                                    imageUrls: imageUrls,
                                    initialIndex: 0,
                                  ),
                                ),
                              );
                            },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (location.thumbnailImage != null)
                            Hero(
                              tag: 'location-thumbnail-${location.id}',
                              child: Image.network(
                                location.thumbnailImage!.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image_not_supported_outlined,
                                size: 72,
                              ),
                            ),

                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.15),
                                  Colors.black.withValues(alpha: 0.65),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 24,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  location.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white70,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        controller.location.address,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 110),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        InfoCard(
                          child: InfoRow(
                            icon: Icons.description_outlined,
                            label: l10n.description,
                            value: controller.location.description,
                          ),
                        ),

                        const SizedBox(height: 16),

                        InfoCard(
                          child: Column(
                            children: [
                              InfoRow(
                                icon: Icons.event_available_outlined,
                                label: l10n.chooseStartdate,
                                value: DateFormat(
                                  'dd.MM.yyyy HH:mm',
                                ).format(controller.location.startDateTime),
                              ),
                              const Divider(height: 24),
                              InfoRow(
                                icon: Icons.event_busy_outlined,
                                label: l10n.chooseEnddate,
                                value: DateFormat(
                                  'dd.MM.yyyy HH:mm',
                                ).format(controller.location.endDateTime),
                              ),
                              const Divider(height: 24),
                              InfoRow(
                                icon: Icons.person_outline,
                                label: l10n.createdBy,
                                value: controller.location.createdUsername,
                                onTap: () => context.push(
                                  RouteConfig.getProfileUrl(
                                    controller.location.createdUsername,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        InfoCard(
                          child: Column(
                            children: [
                              InfoRow(
                                icon: Icons.map_outlined,
                                value: location.address,
                                onTap: (!controller.hasLocation)
                                    ? null
                                    : () => context.push(
                                        RouteConfig.mapUrl,
                                        extra: controller.location,
                                      ),
                              ),

                              const Divider(height: 24),
                              InfoRow(
                                icon: Icons.navigation_outlined,
                                value: l10n.navigateToLocation,
                                onTap: controller.navigateToLocation,
                              ),
                            ],
                          ),
                        ),

                        if (imageUrls.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Text(
                            'Bilder',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          ImageGalleryWidget(
                            imageUrls: imageUrls,
                            dragHandle: AppConfig.isMobile(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: LocationBottomActions(
                isLikeJoinAble: controller.isLikeJoinAble,
                isLiked: controller.isLiked,
                isJoined: controller.isJoined,
                likeCount: controller.likedUserCount,
                joinCount: controller.joinedUserCount,
                onLikeTap: controller.toggleLike,
                onJoinTap: controller.toggleJoin,
              ),
            ),
          ],
        ),

        if (controller.isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
      ],
    );
  }
}
