import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';

class LocationDetailPage extends StatelessWidget {
  final LocationFullResponse location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(location.title), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Bild
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              child: Image.network(
                location.imageUrls.first,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // 📍 Titel + Adresse
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                location.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 20),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      location.position.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // 🗓 Datum
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 6),
                  Text(
                    location.creationDateTime.toIso8601String(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📝 Beschreibung
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                location.description,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
              ),
            ),

            const SizedBox(height: 30),

            // 📌 Koordinaten
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(Icons.map, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Lat: ${location.position.latitude}, Lng: ${location.position.longitude}",
                  ),
                ],
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
      ),
    );
  }
}
