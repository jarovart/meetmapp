import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetmaap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class LocationData {
  final String name;
  final String description;
  final String imageUrl;
  final LatLng position;

  LocationData({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.position,
  });
}


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
    bool serviceEnabled;
    LocationPermission permission;

    // Prüfen ob Standortdienste aktiv sind
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Standortdienste sind deaktiviert")),
      );
      return;
    }

    // Berechtigungen prüfen
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Standortzugriff verweigert")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Standortzugriff dauerhaft verweigert")),
      );
      return;
    }

    // Position abrufen (Browser → JS Geolocation API)
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final latLng = LatLng(pos.latitude, pos.longitude);

    setState(() {
      _currentPosition = latLng;
    });
    // Karte zentrieren und zoomen
    _mapController.move(latLng, 15);
  }

  void _addLocation(LocationData location) {
    setState(() {
      _locations.add(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Fallback, falls noch keine GPS-Daten da sind
    final initialCenter = _currentPosition ?? LatLng(51.1657, 10.4515); // Mitte Deutschland

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
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(value: "Option 1", child: Text("Option 1")),
              const PopupMenuItem(value: "Option 2", child: Text("Option 2")),
              const PopupMenuItem(value: "Option 3", child: Text("Option 3")),
            ];
          },
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
      body: FlutterMap(
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
            if (newLocation != null) {
              _addLocation(newLocation);
            }
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
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(loc.name),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(loc.imageUrl, height: 100),
                            const SizedBox(height: 8),
                            Text(loc.description),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
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
    );
  }
}


class LocationFormPage extends StatefulWidget {
  final LatLng point;

  const LocationFormPage({super.key, required this.point});

  @override
  State<LocationFormPage> createState() => _LocationFormPageState();
}

class _LocationFormPageState extends State<LocationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Neue Location")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                value == null || value.isEmpty ? "Bitte eingeben" : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Beschreibung"),
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                    labelText: "Bild-URL (optional)"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Abbrechen
                    },
                    child: const Text("Abbrechen"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newLocation = LocationData(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          imageUrl: _imageController.text.isNotEmpty
                              ? _imageController.text
                              : "https://via.placeholder.com/150",
                          position: widget.point,
                        );
                        Navigator.pop(context, newLocation);
                      }
                    },
                    child: const Text("Speichern"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nutzerprofil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
            ),
            SizedBox(height: 16),
            Text("Name: Max Mustermann", style: TextStyle(fontSize: 18)),
            Text("E-Mail: max@example.com", style: TextStyle(fontSize: 18)),
            Text("Telefon: +49 123 456789", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
