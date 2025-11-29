import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LocationsPage extends StatelessWidget {
  final String locationId; // falls du sie brauchst – sonst entfernen

  const LocationsPage({super.key, required this.locationId});

  @override
  Widget build(BuildContext context) {
    // Beispiel-Daten – später ersetzt durch Backend
    final locations = List.generate(
      20,
      (i) => {
        "id": i,
        "title": "Coole Location #$i",
        "subtitle": "Adresse $i, Bremen",
        "image":
            "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800",
        "date": "Heute",
      },
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Locations"), centerTitle: true),
      backgroundColor: Colors.grey.shade200,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 👇 Responsive Berechnung
          int crossAxisCount = 1;
          if (constraints.maxWidth >= 1200) {
            crossAxisCount = 3;
          } else if (constraints.maxWidth >= 800) {
            crossAxisCount = 2;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 4 / 3, // Höhe/Breite Verhältnis
            ),
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final loc = locations[index];

              return _LocationCard(
                id: loc["id"].toString(),
                title: loc["title"]!.toString(),
                subtitle: loc["subtitle"]!.toString(),
                imageUrl: loc["image"]!.toString(),
                date: loc["date"]!.toString(),
              );
            },
          );
        },
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String date;

  const _LocationCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => context.push('/location/$id'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(2, 3),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Column(
          children: [
            // Bild oben
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Infos
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Text(date),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
