import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:casttime/features/map/presentation/widgets/debouncer.dart';
import 'package:casttime/features/map/presentation/widgets/location_marker.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_dismiss_barrier.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController mapController;
  late final TileProvider tileProvider;
  late final Debouncer debouncer;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    tileProvider = CancellableNetworkTileProvider();
    debouncer = Debouncer(delay: const Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    mapController.dispose();
    tileProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final dockWidth = width >= 700 ? 520.0 : width - 24;
    debugPrint("map call");

    return Stack(
      children: [
        buildMap(context, dockWidth),
        const SearchDismissBarrier(),
        MapSearchOverlay(dockWidth: dockWidth),
      ],
    );
  }

  Widget buildMap(BuildContext context, double dockWidth) {
    return BlocConsumer<MapBloc, MapState>(
      listenWhen: (previous, current) =>
          (previous.failure != current.failure && current.failure != null) ||
          previous.currentPosition != current.currentPosition,
      listener: (context, state) {
        /*if (state.failure != null) {
          context.read<AppBannerCubit>().showFailure(state.failure!);
          context.read<MapBloc>().add(MapStarted());
          return;
        }*/

        if (state.currentPosition != null) {
          mapController.move(state.currentPosition!, state.zoom);
        }
      },
      buildWhen: (previous, current) =>
          previous.locations != current.locations ||
          previous.selectedLocation != current.selectedLocation ||
          previous.currentPosition != current.currentPosition,
      builder: (context, state) {
        debugPrint(
          "map call blocconsumer with ${state.currentPosition ?? '0.0'}",
        );
        final mapBloc = context.read<MapBloc>();

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: state.currentPosition ?? LatLng(51.1657, 10.4515),
            initialZoom: state.zoom,
            onMapReady: () => mapBloc.add(MapStarted()),
            onMapEvent: (event) {
              if (event is MapEventTap) {
                mapBloc.add(MapLocationDeselected());
              } else if (event is MapEventMoveEnd ||
                  event is MapEventDoubleTapZoomEnd) {
                final bounds = mapController.camera.visibleBounds;
                debugPrint("Bounds changed: $bounds");
                mapBloc.add(MapBoundsChanged(bounds: bounds));
              } else if (event is MapEventScrollWheelZoom) {
                debouncer.run(
                  () => mapBloc.add(
                    MapBoundsChanged(
                      bounds: mapController.camera.visibleBounds,
                    ),
                  ),
                );
              }
            },
          ),
          children: [
            _buildTileLayer(),
            if (state.currentPosition != null)
              _buildMyLocationMarker(context, state.currentPosition!),
            _buildLocationsLayer(context),
          ],
        );
      },
    );
  }

  Widget _buildTileLayer() {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      tileProvider: tileProvider,
      userAgentPackageName: 'de.jarovart.casttime',
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

  Widget _buildLocationsLayer(BuildContext context) {
    final mapBloc = context.read<MapBloc>();

    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 40,
        size: const Size(40, 40),
        zoomToBoundsOnClick: false,
        spiderfyCluster: false,
        markers: mapBloc.state.locations
            .map(
              (loc) => Marker(
                point: loc.position,
                width: 30,
                height: 30,
                child: LocationMarker(
                  location: loc,
                  isSelected: mapBloc.state.selectedLocation?.id == loc.id,
                  onTap: () => _onLocationTapped(context, loc),
                ),
              ),
            )
            .toList(),
        // 🔹 Cluster-Design
        builder: (context, markers) {
          // 🔥 Gewinner ermitteln
          final winningLocation = pickBestLocationFromCluster(markers);

          // 🔥 exakt EIN Marker anzeigen
          return LocationMarker(
            location: winningLocation,
            isSelected:
                mapBloc.state.selectedLocation?.id == winningLocation.id,
            onTap: () => _onLocationTapped(context, winningLocation),
          );
        },
      ),
    );
  }

  void _onLocationTapped(BuildContext context, Location location) {
    debugPrint("location tapped: ${location.title}");
  }

  Location pickBestLocationFromCluster(List<Marker> markers) {
    return markers
        .map((m) => m.child)
        .whereType<LocationMarker>()
        .map((w) => w.location)
        .reduce(
          (a, b) =>
              getLocationScore(
                    likedUserCount: a.likedUserCount,
                    joinedUserCount: a.joinedUserCount,
                    startDateTime: a.startDateTime,
                    endDateTime: a.endDateTime,
                  ) >=
                  getLocationScore(
                    likedUserCount: b.likedUserCount,
                    joinedUserCount: b.joinedUserCount,
                    startDateTime: b.startDateTime,
                    endDateTime: b.endDateTime,
                  )
              ? a
              : b,
        );
  }

  int getLocationScore({
    required int likedUserCount,
    required int joinedUserCount,
    required DateTime startDateTime,
    required DateTime endDateTime,
    DateTime? now,
  }) {
    final n = now ?? DateTime.now();

    var score = likedUserCount * 3 + joinedUserCount;

    // Bonus: Event läuft gerade
    if (startDateTime.isBefore(n) && endDateTime.isAfter(n)) {
      score += 5;
    }

    // Bonus: Startet bald (< 24h) – optional: nur wenn noch nicht gestartet
    final hoursToStart = startDateTime.difference(n).inHours;
    if (hoursToStart >= 0 && hoursToStart < 24) {
      score += 2;
    }

    return score;
  }
}
