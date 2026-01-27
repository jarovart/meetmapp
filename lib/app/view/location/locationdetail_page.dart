import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/util/gallery_widget.dart';
import 'package:meetmaap/app/view/util/imageviewer_widget.dart';

class LocationDetailPage extends StatefulWidget {
  final LocationBaseResponse locationbase;

  const LocationDetailPage({super.key, required this.locationbase});

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  late final Future<LocationFullResponse>? _future;

  @override
  void initState() {
    super.initState();
    _future = LocationService.fetchFullLocation(widget.locationbase.id);
  }

  @override
  Widget build(BuildContext context) {
    // 1) Preview sofort anzeigen (Fallbacks wenn null)
    final dateformatter = DateFormat('dd.MM.yyyy');
    final dateTimeformatter = DateFormat('dd.MM.yyyy HH:mm');
    final title = widget.locationbase.title;

    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: FutureBuilder<LocationFullResponse>(
        future: _future,
        builder: (context, snap) {
          final full = snap.data;

          final title = full?.title ?? widget.locationbase.title;
          final description =
              full?.description ?? widget.locationbase.description;
          final address = full?.address ?? widget.locationbase.address;
          final creationDateTime =
              full?.creationDateTime ?? widget.locationbase.creationDateTime;
          final startDateTime =
              full?.startDateTime ?? widget.locationbase.startDateTime;
          final endDateTime =
              full?.endDateTime ?? widget.locationbase.endDateTime;
          final position = full?.position ?? widget.locationbase.position;
          final thumbnailUrl = (full?.thumbnailUrl.isNotEmpty ?? false)
              ? full!.thumbnailUrl
              : widget.locationbase.thumbnailUrl;
          final createdUsername =
              full?.createdUsername ?? widget.locationbase.createdUsername;
          final joinedUserCount =
              full?.joinedUserCount ?? widget.locationbase.joinedUserCount;
          final likedUserCount =
              full?.likedUserCount ?? widget.locationbase.likedUserCount;

          //Only full location data
          final List<String> imageUrls = (full?.imageUrls.isNotEmpty ?? false)
              ? full!.imageUrls
              : [];

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 📸 Bild
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, _, _) => ImageGalleryViewer(
                          imageUrls: [thumbnailUrl] + imageUrls,
                          initialIndex: 0,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    child: Image.network(
                      thumbnailUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Titel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                // 📝 Beschreibung
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                  ),
                ),

                const SizedBox(height: 10),
                // 📍 Adresse
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  child: GestureDetector(
                    onTap: () => debugPrint(
                      "Lat: ${position.latitude}, Lng: ${position.longitude}",
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            address,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 🗓 Datum
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Wrap(
                          spacing: 22,
                          runSpacing: 8,
                          children: [
                            Text(
                              "Startzeit: ${dateTimeformatter.format(startDateTime)} Uhr",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Endzeit: ${dateTimeformatter.format(endDateTime)} Uhr",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 📌 Erstellt von und Uhrzeit
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.create, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Wrap(
                          spacing: 22,
                          runSpacing: 8,
                          children: [
                            Text(
                              "Erstellt am  ${dateformatter.format(creationDateTime)} von $createdUsername",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (imageUrls.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ImageGalleryWidget(
                      imageUrls: imageUrls,
                      dragHandle: isMobile(),
                    ),
                  ),

                const SizedBox(height: 30),

                // 🧭 Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () {
                          // TODO: Navigation öffnen
                        },
                        icon: const Icon(Icons.navigation_outlined),
                        label: const Text("Navigation starten"),
                      ),

                      const SizedBox(height: 12),

                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: () {
                          // TODO: Auf Karte anzeigen
                        },
                        icon: const Icon(Icons.map_outlined),
                        label: const Text("Auf Karte anzeigen"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          );
        },
      ),
    );
  }

  bool isMobile() {
    if (kIsWeb) return false;

    // Mobile Portrait → BottomSheet
    return (Platform.isAndroid || Platform.isIOS);
  }
}
