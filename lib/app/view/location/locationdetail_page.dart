import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/util/InfoRow.dart';
import 'package:meetmaap/app/view/util/actionstatscard.dart';
import 'package:meetmaap/app/view/util/gallery_widget.dart';
import 'package:meetmaap/app/view/util/imageviewer_widget.dart';
import 'package:meetmaap/app/view/util/infocard.dart';

class LocationDetailPage extends StatefulWidget {
  final LocationBaseResponse locationbase;

  const LocationDetailPage({super.key, required this.locationbase});

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  late final Future<LocationFullResponse>? _future;

  bool _isLiked = false;
  bool _isJoined = false;
  int _likedCount = 0;
  int _joinedCount = 0;

  @override
  void initState() {
    super.initState();
    _future = LocationService.fetchFullLocation(widget.locationbase.id);

    _likedCount = widget.locationbase.likedUserCount;
    _joinedCount = widget.locationbase.joinedUserCount;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationFullResponse>(
      future: _future,
      builder: (context, snap) {
        final full = snap.data;

        final location = full ?? widget.locationbase;
        final title = location.title;
        final description = location.description;
        final address = location.address;
        final thumbnailUrl =
            full?.thumbnailImage?.imageUrl ??
            widget.locationbase.thumbnailImage?.imageUrl ??
            '';

        final imageUrls = full?.images.map((e) => e.imageUrl).toList() ?? [];
        final galleryUrls = [
          if (thumbnailUrl.isNotEmpty) thumbnailUrl,
          ...imageUrls.where((url) => url != thumbnailUrl),
        ];

        final canEdit = _canEditLocation(context, full);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 340,
                pinned: true,
                stretch: true,
                title: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  if (canEdit)
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () {
                        context.push('/location/edit', extra: full);
                      },
                    ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onTap: galleryUrls.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (_, _, _) => ImageGalleryViewer(
                                  imageUrls: galleryUrls,
                                  initialIndex: 0,
                                ),
                              ),
                            );
                          },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (thumbnailUrl.isNotEmpty)
                          Hero(
                            tag: 'location-thumbnail-${location.id}',
                            child: Image.network(
                              thumbnailUrl,
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
                                title,
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
                                      address,
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
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ActionStatsCard(
                        likedCount: _likedCount,
                        joinedCount: _joinedCount,
                        isLiked: _isLiked,
                        isJoined: _isJoined,
                        onLike: _toggleLike,
                        onJoin: _toggleJoin,
                      ),

                      const SizedBox(height: 16),

                      InfoCard(
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.55,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      InfoCard(
                        child: Column(
                          children: [
                            InfoRow(
                              icon: Icons.event_available_outlined,
                              label: 'Start',
                              value: DateFormat(
                                'dd.MM.yyyy HH:mm',
                              ).format(location.startDateTime),
                            ),
                            const Divider(height: 24),
                            InfoRow(
                              icon: Icons.event_busy_outlined,
                              label: 'Ende',
                              value: DateFormat(
                                'dd.MM.yyyy HH:mm',
                              ).format(location.endDateTime),
                            ),
                            const Divider(height: 24),
                            InfoRow(
                              icon: Icons.person_outline,
                              label: 'Erstellt von',
                              value: location.createdUsername,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      InfoCard(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: full == null
                              ? null
                              : () => context.push('/map', extra: full),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.map_outlined),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    address,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                const Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
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
                          dragHandle: isMobile(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        if (full != null) {
                          context.push('/map', extra: full);
                        }
                      },
                      icon: const Icon(Icons.map_outlined),
                      label: const Text('Karte'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Navigation öffnen
                      },
                      icon: const Icon(Icons.navigation_outlined),
                      label: const Text('Route'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _canEditLocation(BuildContext context, LocationFullResponse? full) {
    if (full == null) return false;

    // Beispiel:
    // final auth = context.read<AuthController>();
    // return auth.myProfile?.id == full.createdUserId;

    return false;
  }

  Future<void> _toggleLike() async {
    setState(() {
      _isLiked = !_isLiked;
      _likedCount += _isLiked ? 1 : -1;
    });

    // TODO:
    // await LocationService.toggleLike(widget.locationbase.id);
  }

  Future<void> _toggleJoin() async {
    setState(() {
      _isJoined = !_isJoined;
      _joinedCount += _isJoined ? 1 : -1;
    });

    // TODO:
    // await LocationService.toggleJoin(widget.locationbase.id);
  }

  bool isMobile() {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }
}
