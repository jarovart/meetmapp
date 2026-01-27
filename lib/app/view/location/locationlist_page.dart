import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/service/location_service.dart';
import 'package:meetmaap/app/view/util/locationcard_widget.dart';

class LocationsListPage extends StatefulWidget {
  final LatLng geoposition; // falls du sie brauchst – sonst entfernen

  const LocationsListPage({super.key, required this.geoposition});

  @override
  State<LocationsListPage> createState() => _LocationsListPageState();
}

class _LocationsListPageState extends State<LocationsListPage> {
  late Future<List<LocationBaseResponse>> _futureLocations;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  void _loadLocations() {
    _futureLocations = _fetchLocations();
  }

  Future<List<LocationBaseResponse>> _fetchLocations() async {
    try {
      return await LocationService.fetchLocations();
    } catch (e) {
      debugPrint('Error fetching all locations: $e');
      // Beispiel-Daten – später ersetzt durch Backend
      return List.generate(
        20,
        (i) => LocationBaseResponse(
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
      body: FutureBuilder<List<LocationBaseResponse>>(
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
              int crossAxisCount = max(1, constraints.maxWidth ~/ 400);

              final grid = GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  //childAspectRatio: 4 / 3,
                  mainAxisExtent: 300,
                ),
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final loc = locations[index];

                  return LocationCard(locationbase: loc);
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
