import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/location_base.dart';

class LocationsPage extends StatefulWidget {
  final String locationId; // falls du sie brauchst – sonst entfernen

  const LocationsPage({super.key, required this.locationId});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late Future<List<LocationBase>> _futureLocations;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  void _loadLocations() {
    _futureLocations = _fetchLocations();
  }

  Future<List<LocationBase>> _fetchLocations() async {
    debugPrint("Start: load locations from backend");
    final response = await http.get(
      Uri.parse('http://localhost:8080/api/locations'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      debugPrint("Executed: load locations from backend");
      return body
          .map((e) => LocationBase.fromMap(e as Map<String, dynamic>))
          .toList();
    } else {
      // Beispiel-Daten – später ersetzt durch Backend
      return List.generate(
        20,
        (i) => LocationBase(
          id: i,
          title: "Coole Location #$i",
          description: "Beschreibung $i, Bremen",
          address: "Adresse $i, Bremen",
          creationDateTime: DateTime.now(),
          startDateTime: DateTime.now().add(const Duration(days: 1)),
          endDateTime: DateTime.now().add(const Duration(days: 2)),
          position: LatLng(52.0 + i, 8.0 + i),
          thumbnailUrl:
              "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800",
          createdUserId: i,
          createdUsername: "test123",
          joinedUserCount: 123,
          likedUserCount: 11,
        ),
      );
      //throw Exception('Failed to load locations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Locations"), centerTitle: true),
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder<List<LocationBase>>(
        future: _futureLocations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Fehler: ${snapshot.error}'));
          }

          final locations = snapshot.data ?? [];

          // ⬇️ Optional: wenn keine Locations vorhanden sind
          if (locations.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => _loadLocations(),
              child: ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("Keine Locations gefunden.")),
                ],
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 1;
              if (constraints.maxWidth >= 1200) {
                crossAxisCount = 3;
              } else if (constraints.maxWidth >= 800) {
                crossAxisCount = 2;
              }

              final grid = GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 4 / 3,
                ),
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final loc = locations[index];

                  return _LocationCard(
                    id: loc.id,
                    title: loc.title,
                    // Passe diese Felder an dein LocationBase an:
                    subtitle: loc.description,
                    imageUrl: loc.thumbnailUrl,
                    date: loc.creationDateTime.toIso8601String(),
                  );
                },
              );

              // ⬇️ Pull-to-refresh, damit du manuell neu laden kannst
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _loadLocations();
                  });
                },
                child: grid,
              );
            },
          );
        },
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final int id;
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
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 130,
                  color: Colors.grey[300],
                  alignment: Alignment.center,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
