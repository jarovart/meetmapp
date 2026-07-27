import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:casttime/app/view/util/imageviewer_widget.dart';

class ImageGalleryWidget extends StatefulWidget {
  final bool dragHandle;
  final List<String> imageUrls;

  const ImageGalleryWidget({
    super.key,
    required this.imageUrls,
    this.dragHandle = false,
  });

  @override
  State<ImageGalleryWidget> createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = widget.imageUrls;
    bool dragHandle = widget.dragHandle;

    if (!dragHandle && !isMobile()) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(), // wichtig im ListView
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180, // 🔥 max Breite pro Bild
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1, // quadratisch
        ),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final url = imageUrls[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, _, _) => ImageGalleryViewer(
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
                child: Image.network(url, fit: BoxFit.cover),
              ),
            ),
          );
        },
      );
    } else {
      return SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: imageUrls.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final url = imageUrls[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, _, _) => ImageGalleryViewer(
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
      );
    }
  }

  bool isMobile() {
    if (kIsWeb) return false;

    // Mobile Portrait → BottomSheet
    return (Platform.isAndroid || Platform.isIOS);
  }
}
