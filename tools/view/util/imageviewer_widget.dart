import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:casttime/app/view/util/arrowbutton_widget.dart';

class ImageGalleryViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageGalleryViewer({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<ImageGalleryViewer> createState() => _ImageGalleryViewerState();
}

class _ImageGalleryViewerState extends State<ImageGalleryViewer> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  void _goNext() {
    if (_currentIndex < widget.imageUrls.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  void _goPrevious() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, index) {
              return InteractiveViewer(
                child: Center(
                  child: Hero(
                    tag: widget.imageUrls[index],
                    child: Image.network(
                      widget.imageUrls[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),

          // Close Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 12,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // ⬅️ Pfeil links (Web/Desktop)
          if (kIsWeb)
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: ArrowButton(
                  icon: Icons.chevron_left,
                  onPressed: _currentIndex > 0 ? _goPrevious : null,
                ),
              ),
            ),

          // ➡️ Pfeil rechts (Web/Desktop)
          if (kIsWeb)
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: ArrowButton(
                  icon: Icons.chevron_right,
                  onPressed: _currentIndex < widget.imageUrls.length - 1
                      ? _goNext
                      : null,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ignore: unused_element
  static Widget _imageCard({String? url}) {
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
