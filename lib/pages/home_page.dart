import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/location_data.dart';
import '../services/location_service.dart';
import '../widgets/location_marker.dart';
import '../widgets/center_on_user_button.dart';
import 'location_form_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng? _currentPosition;
  final List<LocationData> _locations = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    final latLng = await LocationService.getCurrentLocation();
    if (latLng != null) {
      setState(() => _currentPosition = latLng);
      _mapController.move(latLng, 15);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Standort konnte nicht ermittelt werden")),
      );
    }
  }

  void _centerOnUser() async {
    await _determinePosition();
  }

  void _addLocation(LocationData location) {
    setState(() {
      _locations.add(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    final initialCenter =
        _currentPosition ?? LatLng(51.1657, 10.4515); // Mitte Deutschland

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meetmaap"),
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Ausgewählt: $value")),
            );
          },
          itemBuilder: (BuildContext context) => const [
            PopupMenuItem(value: "Option 1", child: Text("Option 1")),
            PopupMenuItem(value: "Option 2", child: Text("Option 2")),
            PopupMenuItem(value: "Option 3", child: Text("Option 3")),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 6,
              onLongPress: (tapPosition, point) async {
                final newLocation = await Navigator.push<LocationData>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationFormPage(point: point),
                  ),
                );
                if (newLocation != null) _addLocation(newLocation);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: _locations
                    .map(
                      (loc) => Marker(
                    point: loc.position,
                    width: 80,
                    height: 80,
                    child: LocationMarker(location: loc),
                  ),
                )
                    .toList(),
              ),
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentPosition!,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          CenterOnUserButton(onPressed: _centerOnUser),
        ],
      ),
    );
  }
}
