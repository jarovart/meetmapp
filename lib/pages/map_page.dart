import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../features/locations/data/location_data.dart';
import '../features/locations/logic/location_service.dart';
import '../common/widgets/location_marker.dart';
import '../common/widgets/center_on_user_button.dart';
import '../features/locations/presentation/location_form_page.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  LatLng? _currentPosition;
  final List<LocationData> _locations = [];
  final MapController _mapController = MapController();
  final List<String> _dayOptions = [
    'Heute',
    'Morgen',
    'Übermorgen',
    '1 Woche',
    '1 Monat',
  ];
  RangeValues _selectedRange = RangeValues(0, 4);

  @override
  Widget build(BuildContext context) {
    final initialCenter =
        _currentPosition ?? LatLng(51.1657, 10.4515); // Mitte Deutschland

    return Stack(
      children: [
        // FlutterMap with only layer children
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
            _buildTileLayer(),
            _buildLocationsLayer(),
            if (_currentPosition != null) _buildUserMarker(),
          ],
        ),
        // Overlay: Search Bar and Slider/GPS positioned on top
        _buildSearchBar(),
        _buildDateSliderAndGps(),
      ],
    );
  }

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
        showError("Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        showError("Standort-Berechtigung verweigert");
      case LocationError(:final message):
        showError("Fehler: $message");
    }
  }

  void _centerOnUser() async => await _determinePosition();

  void _addLocation(LocationData location) {
    setState(() => _locations.add(location));
  }

  Widget _buildSearchBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.15; // 70% width centered
    final topOffset = 15.0;
    /*MediaQuery.of(context).padding.top +
        kToolbarHeight +
        CenterOnUserButton.padding;*/

    return Positioned(
      left: sidePadding,
      right: sidePadding,
      top: topOffset,
      child: SafeArea(
        top: false,
        child: Material(
          elevation: 0,
          color: Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(24),
          //color: Colors.white.withOpacity(0.1), // 90% transparent
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Suchen...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              style: const TextStyle(color: Colors.black),
              onSubmitted: (value) {
                if (value.trim().isEmpty) return;
                showError('Suche: $value');
                // TODO: wire real search behavior (filter markers / navigate)
              },
            ),
          ),
        ),
      ),
    );
  }

  //TODO artem doppelt
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
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

  Widget _buildDateSliderAndGps() {
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.2; // default padding to get ~60% width
    final fabDiameter = 40.0; // mini FAB diameter
    final bottomPadding = CenterOnUserButton.padding;

    final fullWidthMode = screenWidth < 420.0;

    final left = fullWidthMode ? 12.0 : sidePadding;
    final right = fullWidthMode ? 12.0 : sidePadding;

    // Transparent material and reduced height to match GPS button
    final sliderWidget = SafeArea(
      top: false,
      child: SizedBox(
        height: fabDiameter,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.blue.withValues(alpha: 0.3),
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withValues(alpha: 0.15),
                trackHeight: 2,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
              ),
              child: RangeSlider(
                values: _selectedRange,
                min: 0,
                max: (_dayOptions.length - 1).toDouble(),
                divisions: _dayOptions.length - 1,
                labels: RangeLabels(
                  _dayOptions[_selectedRange.start.round()],
                  _dayOptions[_selectedRange.end.round()],
                ),
                onChanged: (values) => setState(() {
                  // snap to discrete steps
                  final start = values.start.roundToDouble();
                  final end = values.end.roundToDouble();
                  _selectedRange = RangeValues(start, end);
                }),
              ),
            ),
          ),
        ),
      ),
    );

    // GPS button positioning: default bottom-right; in fullWidthMode place it top-right of slider
    final gpsWidget = Positioned(
      right: fullWidthMode ? right : CenterOnUserButton.padding,
      bottom: fullWidthMode
          ? bottomPadding + fabDiameter + 8.0
          : CenterOnUserButton.padding,
      child: CenterOnUserButton(onPressed: _centerOnUser),
    );

    final sliderPositioned = Positioned(
      left: left,
      right: right,
      bottom: bottomPadding,
      child: sliderWidget,
    );

    return Stack(children: [sliderPositioned, gpsWidget]);
  }
}
