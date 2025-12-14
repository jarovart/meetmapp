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
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          snap: true,
          snapSizes: const [0.5, 1.0],
          expand: false,
          initialChildSize: 0.5, // 40% Höhe beim Öffnen
          minChildSize: 0.25, // minimal (nach unten ziehen)
          maxChildSize: 1.0, // 🔥 volle Höhe beim Hochziehen
          builder: (context, scrollController) {
            return Material(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              child: ListView(
                controller: scrollController, // 🔥 extrem wichtig
                padding: const EdgeInsets.all(16),
                children: [
                  // optionaler Drag-Handle
                  const SizedBox(height: 8),
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

                  Text(
                    location.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    location.description,
                    style: const TextStyle(fontSize: 16),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _imageCard(),
                        _imageCard(),
                        _imageCard(),
                        _imageCard(),
                        _imageCard(),
                      ],
                    ),
                  ),

                  // Beispiel: zusätzlicher Content
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Weitere Informationen',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Weitere Informationen1',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
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
      height: 300,
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
