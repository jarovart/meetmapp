import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:meetmaap/app/controller/map_controller.dart';
import 'package:meetmaap/app/model/responses/locationbase_response.dart';
import 'package:meetmaap/app/model/responses/locationfull_response.dart';
import 'package:meetmaap/app/view/location/locationdetails_bottomsheet_mobile.dart';
import 'package:meetmaap/app/view/location/locationdetails_generaldialog_nomobile.dart';
import 'package:meetmaap/app/view/util/locationmarker_widget.dart';
import 'package:meetmaap/app/view/util/geolocationbutton_widget.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  final LocationFullResponse? locationToCheck;

  const MapPage({super.key, this.locationToCheck});

  @override
  Widget build(BuildContext context) {
    final mapViewController = context.watch<MapViewController>();

    // Show only a single location e.g. in a stack of location details
    if (locationToCheck != null) {
      return Scaffold(
        appBar: AppBar(title: Text("Location von ${locationToCheck!.title}")),
        body: buildMap(
          context,
          mapViewController,
          locationToCheck: locationToCheck,
        ),
      );
    }

    // Standard process with full map and all locations
    mapViewController.loadData();
    return buildMap(context, mapViewController);
  }

  Widget buildMap(
    BuildContext context,
    MapViewController mapViewController, {
    LocationFullResponse? locationToCheck,
  }) {
    bool noLocationToCheck = locationToCheck == null;
    return Stack(
      children: [
        FlutterMap(
          mapController: mapViewController.mapController,
          options: noLocationToCheck
              ? MapOptions(
                  initialCenter: mapViewController.initialCenter,
                  initialZoom: 6.0,
                  onMapEvent: (event) {
                    if (event is MapEventTap) {
                      mapViewController.selectLocation(null);
                    } else if (event is MapEventLongPress) {
                      mapViewController.createLocation(
                        context,
                        event.tapPosition,
                      );
                    } else if (event is MapEventMoveEnd ||
                        event is MapEventDoubleTapZoomEnd) {
                      mapViewController.fetchLocations();
                    } else if (event is MapEventScrollWheelZoom) {
                      mapViewController.debouncer.run(
                        () => mapViewController.fetchLocations(),
                      );
                    }
                  },
                )
              : MapOptions(
                  initialCenter: locationToCheck.position,
                  initialZoom: 13.0,
                  onMapEvent: (event) {
                    if (event is MapEventTap) {
                      mapViewController.selectLocation(null);
                    }
                  },
                ),
          children: _buildMapChildren(
            context,
            mapViewController,
            noLocationToCheck,
            locationToCheck,
          ),
        ),
        // Overlay: Search Bar and Slider/GPS positioned on top
        _buildMapSiblings(context, mapViewController, noLocationToCheck),
      ],
    );
  }

  List<Widget> _buildMapChildren(
    BuildContext context,
    MapViewController mapViewController,
    bool noLocationToCheck,
    LocationFullResponse? locationToCheck,
  ) {
    if (noLocationToCheck) {
      return [
        _buildTileLayer(),
        if (mapViewController.currentPosition != null)
          _buildMyLocationMarker(mapViewController.currentPosition!),
        _buildLocationsLayer(context, mapViewController),
      ];
    }
    return [
      _buildTileLayer(),
      _buildLocationSoloMarker(context, mapViewController, locationToCheck!),
    ];
  }

  Widget _buildTileLayer() {
    return TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      tileProvider: CancellableNetworkTileProvider(),
      userAgentPackageName: 'de.jarovart.meetmaap',
    );
  }

  Widget _buildMapSiblings(
    BuildContext context,
    MapViewController mapViewController,
    bool noLocationToCheck,
  ) {
    if (!noLocationToCheck) return const SizedBox.shrink();

    return Stack(
      children: [
        _buildDateSliderAndGps(context, mapViewController),
        _buildSearchResults(context, mapViewController),
        _buildSearchBar(context, mapViewController),
      ],
    );
  }

  Widget _buildLocationSoloMarker(
    BuildContext context,
    MapViewController mapViewController,
    LocationFullResponse locationFullResponse,
  ) {
    return MarkerLayer(
      markers: [
        Marker(
          point: locationFullResponse.position,
          width: 30,
          height: 30,
          child: LocationMarker(
            location: locationFullResponse,
            isSelected:
                mapViewController.selectedLocation?.id ==
                locationFullResponse.id,
            onTap: () => _onLocationTapped(
              context,
              mapViewController,
              locationFullResponse,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationsLayer(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 40,
        size: const Size(40, 40),
        zoomToBoundsOnClick: false,
        spiderfyCluster: false,
        markers: mapViewController.locations
            .map(
              (loc) => Marker(
                point: loc.position,
                width: 30,
                height: 30,
                child: LocationMarker(
                  location: loc,
                  isSelected: mapViewController.selectedLocation?.id == loc.id,
                  onTap: () =>
                      _onLocationTapped(context, mapViewController, loc),
                ),
              ),
            )
            .toList(),
        // 🔹 Cluster-Design
        builder: (context, markers) {
          // 🔥 Gewinner ermitteln
          final winningLocation = mapViewController.pickBestLocationFromCluster(
            markers,
          );

          // 🔥 exakt EIN Marker anzeigen
          return LocationMarker(
            location: winningLocation,
            isSelected:
                mapViewController.selectedLocation?.id == winningLocation.id,
            onTap: () =>
                _onLocationTapped(context, mapViewController, winningLocation),
          );
        },
      ),
    );
  }

  Widget _buildMyLocationMarker(LatLng currentPosition) {
    return MarkerLayer(
      markers: [
        Marker(
          point: currentPosition,
          width: 60,
          height: 60,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
        ),
      ],
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.15;
    final topOffset = 15.0;
    final searchController = mapViewController.searchController;

    return Positioned(
      left: sidePadding,
      right: sidePadding,
      top: topOffset,
      child: SafeArea(
        top: false,
        child: Material(
          elevation: 0,
          color: const Color.fromARGB(
            255,
            223,
            222,
            222,
          ).withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: searchController,
              onChanged: mapViewController.onSearchChanged,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Suchen...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[700]),
                        onPressed: () {
                          searchController.clear();
                          mapViewController.clearSearchResults();
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

  Widget _buildSearchResults(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    if (mapViewController.searchResults.isEmpty) return SizedBox.shrink();
    final sidePadding = MediaQuery.of(context).size.width * 0.15;

    return Positioned.fill(
      child: Stack(
        children: [
          // 🔹 Graues Overlay (Tap schließt Suche)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              mapViewController.clearSearchResults();
              mapViewController.searchController.clear();
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
                itemCount: mapViewController.searchResults.length,
                itemBuilder: (context, index) {
                  final loc = mapViewController.searchResults[index];

                  return ListTile(
                    leading: Icon(Icons.location_on, color: Colors.green),
                    title: Text(loc.title),
                    subtitle: Text(loc.description),
                    onTap: () {
                      _onLocationTapped(context, mapViewController, loc);
                      mapViewController.clearSearchResults();
                      mapViewController.searchController.clear();
                      mapViewController.fetchLocations();
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

  Widget _buildDateSliderAndGps(
    BuildContext context,
    MapViewController mapViewController,
  ) {
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
                values: mapViewController.selectedRange,
                min: 0,
                max: (mapViewController.dayOptions.length - 1).toDouble(),
                divisions: mapViewController.dayOptions.length - 1,
                labels: RangeLabels(
                  mapViewController.setDayOptionsText(
                    mapViewController.selectedRange.start,
                  ),
                  mapViewController.setDayOptionsText(
                    mapViewController.selectedRange.end,
                  ),
                ),
                onChanged: (values) {
                  // snap to discrete steps
                  final start = values.start.roundToDouble();
                  final end = values.end.roundToDouble();
                  mapViewController.setDateRange(RangeValues(start, end));

                  mapViewController.debouncer.run(
                    () => mapViewController.fetchLocations(),
                  );
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
      child: CenterOnUserButton(onPressed: mapViewController.centerOnUser),
    );

    final sliderPositioned = Positioned(
      left: left,
      right: right,
      bottom: bottomPadding,
      child: sliderWidget,
    );

    return Stack(children: [sliderPositioned, gpsWidget]);
  }

  void _onLocationTapped(
    BuildContext context,
    MapViewController mapViewController,
    LocationBaseResponse location,
  ) {
    mapViewController.selectLocation(location);
    mapViewController.mapController.move(
      location.position,
      mapViewController.mapController.camera.zoom,
    );

    if (_useBottomSheetForMobile(context)) {
      mapViewController.shiftTargetForView(location.position);
      LocationDetailsBottomSheet.show(context, locationBase: location).then((
        _,
      ) {
        mapViewController.restoreCenterAfterSheet();
        mapViewController.selectLocation(null);
      });
    } else {
      mapViewController.shiftTargetForView(
        location.position,
        isMobileSheetOpen: false,
      );
      LocationDetailsGeneralDialog.show(context, locationBase: location).then((
        _,
      ) {
        mapViewController.restoreCenterAfterSheet();
        mapViewController.selectLocation(null);
      });
    }
  }

  bool _useBottomSheetForMobile(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Web → niemals BottomSheet
    if (kIsWeb) return false;

    // Mobile Portrait → BottomSheet
    return (Platform.isAndroid || Platform.isIOS) && size.width < size.height;
  }
}
