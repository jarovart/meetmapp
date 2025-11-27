import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../features/locations/data/location_data.dart';
import '../features/locations/logic/location_service.dart';
import '../common/widgets/location_marker.dart';
import '../common/widgets/center_on_user_button.dart';
import '../features/locations/presentation/location_form_page.dart';
import '../features/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  LatLng? _currentPosition;
  final List<LocationData> _locations = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    final result = await LocationService.getCurrentLocation();

    switch (result) {
      case LocationSuccess(:final position):
        setState(() => _currentPosition = position);
        _mapController.move(position, 15);
      case LocationServiceDisabled():
        _showErrorSnackBar("Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        _showErrorSnackBar("Standort-Berechtigung verweigert");
      case LocationError(:final message):
        _showErrorSnackBar("Fehler: $message");
    }
  }

  void _centerOnUser() async => await _determinePosition();

  void _addLocation(LocationData location) {
    setState(() => _locations.add(location));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final initialCenter =
        _currentPosition ?? LatLng(51.1657, 10.4515); // Mitte Deutschland

    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildMap(initialCenter),
          CenterOnUserButton(onPressed: _centerOnUser),
        ],
      ),
    );
  }

  /// ---------- UI-Aufteilung ----------

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Meetmaap"),
      leading: _buildMenu(),
      actions: [_buildProfileAvatar()],
    );
  }

  Widget _buildMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu),
      onSelected: (value) {
        _showErrorSnackBar("Ausgewählt: $value");
      },
      itemBuilder: (BuildContext context) => const [
        PopupMenuItem(value: "Option 1", child: Text("Option 1")),
        PopupMenuItem(value: "Option 2", child: Text("Option 2")),
        PopupMenuItem(value: "Option 3", child: Text("Option 3")),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            "https://ui-avatars.com/api/?name=Artem&background=0D8ABC&color=fff",
          ),
        ),
      ),
    );
  }

  Widget _buildMap(LatLng initialCenter) {
    return FlutterMap(
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
        _buildTileLayer(),
        _buildLocationsLayer(),
        if (_currentPosition != null) _buildUserMarker(),
      ],
    );
  }

  Widget _buildTileLayer() {
    return TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: 'de.jarovart.meetmaap',
    );
  }

  Widget _buildLocationsLayer() {
    return MarkerLayer(
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
    );
  }

  Widget _buildUserMarker() {
    return MarkerLayer(
      markers: [
        Marker(
          point: _currentPosition!,
          width: 60,
          height: 60,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
        ),
      ],
    );
  }
}
