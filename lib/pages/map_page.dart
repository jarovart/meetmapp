import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/common/utils/debouncer.dart';
import 'package:meetmaap/config/api_config.dart';
import 'package:meetmaap/features/locations/data/location_base.dart';
import 'package:meetmaap/features/locations/logic/location_service.dart';
import 'package:meetmaap/common/widgets/location_marker.dart';
import 'package:meetmaap/common/widgets/center_on_user_button.dart';
import 'package:meetmaap/common/utils/exception_message.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  LatLng _initialCenter = LatLng(51.1657, 10.4515); // Mitte von Deutschland
  LatLng? _currentPosition;
  LocationBase? _selectedLocation;
  List<LocationBase> _locations = [];
  List<LocationBase> _searchResults = [];

  RangeValues _selectedRange = RangeValues(0, 4);
  final List<String> _dayOptions = [
    'Heute',
    'Morgen',
    'Übermorgen',
    '1 Woche',
    '1 Monat',
  ]; // Beispielwerte
  late Debouncer _debouncer;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    debugPrint("Start: InitState MapPage");
    _debouncer = Debouncer(delay: Duration(milliseconds: 1000));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLocationsByCurrentPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // FlutterMap with only layer children
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _initialCenter,
            initialZoom: 6.0,
            onMapEvent: (event) {
              if (event is MapEventTap) {
                setState(() => _selectedLocation = null);
              } else if (event is MapEventLongPress) {
                _createLocation(context, event.tapPosition);
              } else if (event is MapEventMoveEnd ||
                  event is MapEventDoubleTapZoomEnd ||
                  event is MapEventScrollWheelZoom) {
                _debouncer.run(() => _fetchLocationsByCurrentPosition());
              }
            },
          ),
          children: [
            _buildTileLayer(),
            if (_currentPosition != null) _buildMyLocationMarker(),
            _buildLocationsLayer(),
          ],
        ),
        // Overlay: Search Bar and Slider/GPS positioned on top
        _buildDateSliderAndGps(),
        _buildSearchResults(),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildTileLayer() {
    return TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      tileProvider: CancellableNetworkTileProvider(),
      userAgentPackageName: 'de.jarovart.meetmaap',
    );
  }

  Widget _buildLocationsLayer() {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 45,
        size: const Size(40, 40),
        markers:
            _locations
                .map(
                  (loc) => Marker(
                    point: loc.position,
                    width: 80,
                    height: 80,
                    child: LocationMarker(
                      location: loc,
                      isSelected: _selectedLocation?.id == loc.id,
                      onTapCallback: () {
                        if (_selectedLocation?.id == loc.id) {
                          setState(() {
                            _selectedLocation = null;
                          });
                        } else {
                          setState(() {
                            _selectedLocation = loc;
                          });
                        }

                        if (_mapController.camera.center != loc.position) {
                          _mapController.move(
                            loc.position,
                            _mapController.camera.zoom,
                          );
                          _fetchLocationsByCurrentPosition();
                        }
                      },
                    ),
                  ),
                )
                .toList()
              ..sort((a, b) {
                if (a.point == _selectedLocation?.position) return 1;
                if (b.point == _selectedLocation?.position) return -1;
                return 0;
              }),
        // 🔹 Cluster-Design
        builder: (context, markers) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: Text(
              markers.length.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMyLocationMarker() {
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
              controller: _searchController,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Suchen...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[700]),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchResults.clear());
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) return SizedBox.shrink();

    final sidePadding = MediaQuery.of(context).size.width * 0.15;

    return Positioned.fill(
      child: Stack(
        children: [
          // 🔹 Graues Overlay (Tap schließt Suche)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _searchResults.clear();
              });
              _searchController.clear();
            },
            child: Container(color: Colors.black.withValues(alpha: 0.25)),
          ),
          Positioned(
            left: sidePadding,
            right: sidePadding,
            top: 70,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final loc = _searchResults[index];

                  return ListTile(
                    leading: Icon(Icons.location_on, color: Colors.green),
                    title: Text(loc.title),
                    subtitle: Text(loc.description),
                    onTap: () {
                      _mapController.move(
                        loc.position,
                        _mapController.camera.zoom,
                      );
                      setState(() {
                        _selectedLocation = loc;
                        _locations.add(loc);
                        _searchResults.clear();
                      });
                      _searchController.clear();
                      _fetchLocationsByCurrentPosition();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String text) {
    setState(() {}); // ← sorgt dafür, dass das X erscheint/verschwindet
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      if (text.length < 3) {
        setState(() => _searchResults.clear());
        return;
      }

      try {
        final results = await searchLocations(text);

        // nach Entfernung sortieren (falls _currentPosition != null)
        if (_currentPosition != null) {
          results.sort((a, b) {
            final distA = Distance().as(
              LengthUnit.Kilometer,
              _currentPosition!,
              a.position,
            );
            final distB = Distance().as(
              LengthUnit.Kilometer,
              _currentPosition!,
              b.position,
            );
            return distA.compareTo(distB);
          });
        }

        if (!mounted) return;

        setState(() {
          _searchResults = results;
        });
      } catch (e) {
        ExceptionMessage.showError(context, "Suche fehlgeschlagen");
      }
    });
  }

  Widget _buildDateSliderAndGps() {
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.2; // default padding to get ~60% width
    final fabDiameter = 40.0; // mini FAB diameter
    final bottomPadding = CenterOnUserButton.padding;

    final fullWidthMode = screenWidth < 620.0;

    final left = fullWidthMode ? 12.0 : sidePadding;
    final right = fullWidthMode ? 12.0 : sidePadding;

    // Transparent material and reduced height to match GPS button

    final sliderWidget = SafeArea(
      top: true,
      child: SizedBox(
        height: fabDiameter,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.onDrag,
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
                onChanged: (values) {
                  setState(() {
                    // snap to discrete steps
                    final start = values.start.roundToDouble();
                    final end = values.end.roundToDouble();
                    _selectedRange = RangeValues(start, end);
                  });
                  _debouncer.run(() => _fetchLocationsByCurrentPosition());
                },
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
          ? bottomPadding + fabDiameter + 28.0
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

  /// Zentriert die Karte auf die aktuelle Benutzerposition.
  void _centerOnUser() async => await _determinePosition();

  /// Bestimmt die aktuelle Position des Benutzers und aktualisiert die Karte.
  Future<void> _determinePosition() async {
    final result = await LocationService.getCurrentLocation();

    if (!mounted) return; // Ist das Widget noch im Baum?
    switch (result) {
      case LocationSuccess(:final position):
        setState(() {
          _initialCenter = position;
          _currentPosition = position;
        });
        _mapController.move(position, 13.00); //todo auf 15 ändern
      case LocationServiceDisabled():
        ExceptionMessage.showError(context, "Standortdienste sind deaktiviert");
      case LocationPermissionDenied():
        ExceptionMessage.showError(context, "Standort-Berechtigung verweigert");
      case LocationError(:final message):
        ExceptionMessage.showError(context, "Fehler: $message");
    }
  }

  Future<void> _fetchLocationsByCurrentPosition() async {
    try {
      debugPrint("Start: _fetchLocationsByCurrentPosition");
      final locations = await LocationService.fetchAllLocationsInView(
        _mapController.camera.visibleBounds,
      );
      if (!mounted) return;
      setState(() => _locations = locations);
      debugPrint("Execute: _fetchLocationsByCurrentPosition");
    } catch (e) {
      if (!mounted) return;
      debugPrint("Exception: _fetchLocationsByCurrentPosition");
      //ExceptionMessage.showError(context, "Fehler beim Laden der Locations");
    }
  }

  void _createLocation(BuildContext context, LatLng tapPosition) async {
    final createdLocation = await context.push<LocationBase>(
      "/locationcreate/${tapPosition.latitude}/${tapPosition.longitude}",
    );

    if (createdLocation != null) {
      setState(() {
        _locations.add(createdLocation);
        _selectedLocation = createdLocation;
      });
      _mapController.move(createdLocation.position, _mapController.camera.zoom);
    }
  }

  /// Sucht nach Locations basierend auf der Suchanfrage.
  static Future<List<LocationBase>> searchLocations(String query) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}/api/locations/search?query=$query',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Fehler beim Suchen");
    }

    final body = jsonDecode(response.body) as List;
    return body.map((e) => LocationBase.fromMap(e)).toList();
  }
}
