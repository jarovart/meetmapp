import 'package:flutter/material.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';

class LocationMarker extends StatelessWidget {
  final LocationBase location;
  final bool isSelected;
  final VoidCallback? onTapCallback;

  const LocationMarker({
    super.key,
    this.isSelected = false,
    required this.location,
    this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTapCallback != null) onTapCallback!();
        if (!isSelected) _showLocationDialog(context);
      },
      child: _buildMarkerIcon(),
    );
  }

  /// ---------- UI-Aufteilung ----------
  Widget _buildMarkerIcon() {
    return Icon(
      Icons.location_on,
      color: isSelected ? Colors.blue : Colors.red,
      size: isSelected ? 40 : 30,
    );
  }

  void _showLocationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      //isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      enableDrag: true,
      builder: (context) {
        return DraggableScrollableSheet(
          snap: true,
          snapSizes: const [0.5, 0.7, 1.0],
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Material(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: SafeArea(
                top: true, // ✅ schützt Statusbar
                bottom: true, // ✅ schützt Gesten-Navigation
                child: CustomScrollView(
                  controller: scrollController,
                  //primary: false,
                  //physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // 🔹 Header (zieht das Sheet)
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            location.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Ort',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔹 Horizontal scrollbare Bilder (wie Google Maps)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 220,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [_imageCard(), _imageCard(), _imageCard()],
                        ),
                      ),
                    ),

                    // 🔹 Vertikal scrollbare Inhalte
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return ListTile(title: Text('Menüpunkt $index'));
                      }, childCount: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _imageCard() {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
