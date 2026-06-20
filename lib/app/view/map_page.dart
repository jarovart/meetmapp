import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:casttime/app/controller/map_controller.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/app/model/response/locationfull_response.dart';
import 'package:casttime/app/view/location/locationdetails_bottomsheet_mobile.dart';
import 'package:casttime/app/view/location/locationdetails_generaldialog_nomobile.dart';
import 'package:casttime/app/view/util/app_errormessage_mapper.dart';
import 'package:casttime/app/view/util/locationmarker_widget.dart';
import 'package:casttime/app/view/util/geolocationbutton_widget.dart';
import 'package:casttime/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  final LocationFullResponse? locationToCheck;

  const MapPage({super.key, this.locationToCheck});

  @override
  Widget build(BuildContext context) {
    final mapViewController = context.watch<MapViewController>();
    mapViewController.setOnlyOneLocation(locationToCheck);
    final l10n = context.l10n;

    mapViewController.dayOptions = [
      l10n.today,
      l10n.tomorrow,
      l10n.dayAfterTomorrow,
      l10n.nextWeek,
      l10n.nextMonth,
    ];

    if (mapViewController.isOnlyOneLocation) {
      return Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.locationOf(locationToCheck!.title)),
        ),
        body: buildMap(context, mapViewController),
      );
    }

    // Standard process with full map and all locations
    mapViewController.loadData();
    return buildMap(context, mapViewController);
  }

  Widget buildMap(BuildContext context, MapViewController mapViewController) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapViewController.mapController,
          options: !mapViewController.isOnlyOneLocation
              ? MapOptions(
                  initialCenter: mapViewController.initialCenter,
                  initialZoom: 6.0,
                  onMapEvent: (event) {
                    if (event is MapEventTap) {
                      mapViewController.selectLocation(null);
                    } else if (event is MapEventLongPress) {
                      mapViewController.selectLocation(null);
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
                  initialCenter: mapViewController.locationToCheck!.position,
                  initialZoom: 13.0,
                  onMapEvent: (event) {
                    if (event is MapEventTap) {
                      mapViewController.selectLocation(null);
                    } else if (event is MapEventLongPress) {
                      GoRouter.of(context).pop(event.tapPosition);
                    }
                  },
                ),
          children: _buildMapChildren(context, mapViewController),
        ),
        // Overlay: Search Bar and Slider/GPS positioned on top
        _buildMapSiblings(context, mapViewController),
      ],
    );
  }

  List<Widget> _buildMapChildren(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    if (!mapViewController.isOnlyOneLocation) {
      return [
        _buildTileLayer(context),
        if (mapViewController.currentPosition != null)
          _buildMyLocationMarker(context, mapViewController.currentPosition!),
        _buildLocationsLayer(context, mapViewController),
      ];
    }
    return [
      _buildTileLayer(context),
      _buildLocationSoloMarker(
        context,
        mapViewController,
        mapViewController.locationToCheck!,
      ),
    ];
  }

  Widget _buildTileLayer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        TileLayer(
          urlTemplate: /* isDark
          ? "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png"
          :*/
              "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          //subdomains: isDark ? const ['a', 'b', 'c', 'd'] : const [],
          //retinaMode: isDark ? RetinaMode.isHighDensity(context) as bool? : null,
          tileProvider: CancellableNetworkTileProvider(),
          userAgentPackageName: 'de.jarovart.casttime',
        ),
        if (Theme.of(context).brightness == Brightness.dark)
          PolygonLayer(
            polygons: [
              Polygon(
                points: [
                  const LatLng(-90, -180),
                  const LatLng(-90, 180),
                  const LatLng(90, 180),
                  const LatLng(90, -180),
                ],
                color: Colors.black.withValues(alpha: 0.55),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMapSiblings(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    if (mapViewController.isOnlyOneLocation) {
      return _buildInfoBar(context, mapViewController);
    }

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

  Widget _buildMyLocationMarker(BuildContext context, LatLng currentPosition) {
    final colors = Theme.of(context).colorScheme;

    return MarkerLayer(
      markers: [
        Marker(
          point: currentPosition,
          width: 60,
          height: 60,
          child: Icon(Icons.my_location, color: colors.primary, size: 40),
        ),
      ],
    );
  }

  Widget _buildInfoBar(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      left: 0,
      right: 0,
      child: IgnorePointer(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 24,
                  spreadRadius: 2,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.place_outlined, size: 28, color: Colors.black87),
                SizedBox(height: 8),
                Text(
                  context.l10n.choosePerfectPlace,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  context.l10n.longPressSetPostion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(
    BuildContext context,
    MapViewController mapViewController,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.15;
    final topOffset = 15.0;
    final searchController = mapViewController.searchController;
    final isFocused = mapViewController.searchFocusNode.hasFocus;

    return Positioned(
      left: sidePadding,
      right: sidePadding,
      top: topOffset,
      child: SafeArea(
        top: false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isFocused
                ? colors.surface.withValues(alpha: 0.95)
                : colors.surfaceContainerHighest.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isFocused
                  ? colors.primary
                  : colors.outline.withValues(alpha: 0.25),
              width: 1.5,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                focusNode: mapViewController.searchFocusNode,
                controller: searchController,
                onChanged: mapViewController.onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: context.l10n.searching,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: colors.onSurfaceVariant,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: colors.onSurfaceVariant,
                          ),
                          onPressed: () {
                            searchController.clear();
                            mapViewController.clearSearchState();
                          },
                        )
                      : null,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
                style: TextStyle(color: colors.onSurface),
              ),
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
    final query = mapViewController.searchController.text.trim();
    final hasQuery = query.isNotEmpty;
    final hasResults = mapViewController.searchResults.isNotEmpty;
    final hasError = mapViewController.hasSearchError;
    final isLoading = mapViewController.isSearchLoading;
    final showNoResults =
        query.length >= 3 && !isLoading && !hasError && !hasResults;

    if (!hasQuery && !hasResults && !hasError && !isLoading) {
      return const SizedBox.shrink();
    }

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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 320),
                child: Builder(
                  builder: (context) {
                    if (isLoading) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 12),
                            Text(context.l10n.searching),
                          ],
                        ),
                      );
                    }

                    if (hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                AppErrorMapper.toUserMessage(
                                  mapViewController.searchError!,
                                  context.l10n,
                                  fallback: context.l10n.errorSearch,
                                ),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (showNoResults) {
                      return Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Icon(Icons.search_off),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(context.l10n.noLocationsFound),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: mapViewController.searchResults.length,
                      itemBuilder: (context, index) {
                        final loc = mapViewController.searchResults[index];

                        return ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                          ),
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
                    );
                  },
                ),
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
    final theme = Theme.of(context);
    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.2; // default padding to get ~60% width
    final fabDiameter = 40.0; // mini FAB diameter
    final bottomPadding = CenterOnUserButton.padding;

    final fullWidthMode = screenWidth < 620.0;

    final left = fullWidthMode ? 12.0 : sidePadding;
    final right = fullWidthMode ? 12.0 : sidePadding;

    final sliderWidget = SafeArea(
      top: true,
      child: SizedBox(
        height: fabDiameter,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                activeTrackColor: theme.iconTheme.color,
                inactiveTrackColor: colors.secondary.withValues(alpha: 0.3),
                thumbColor: colors.primary,
                overlayColor: colors.primary.withValues(alpha: 0.15),
                valueIndicatorColor: theme.cardTheme.color!.withValues(
                  alpha: 0.2,
                ),
                valueIndicatorTextStyle: TextStyle(color: colors.primary),
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
    debugPrint("onLocationTapped is called");

    if (_useBottomSheetForMobile(context)) {
      mapViewController.shiftTargetForView(location.position);
      LocationDetailsBottomSheet.show(
        context,
        locationBase: location,
        canOpenInNewPage: !mapViewController.isOnlyOneLocation,
      ).then((_) {
        mapViewController.restoreCenterAfterSheet();
        mapViewController.selectLocation(null);
      });
    } else {
      mapViewController.shiftTargetForView(
        location.position,
        isMobileSheetOpen: false,
      );
      LocationDetailsGeneralDialog.show(
        context,
        locationBase: location,
        canOpenInNewPage: !mapViewController.isOnlyOneLocation,
      ).then((_) {
        mapViewController.restoreCenterAfterSheet();
        mapViewController.selectLocation(null);
      });
    }
  }

  bool _useBottomSheetForMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 700;
  }
}
