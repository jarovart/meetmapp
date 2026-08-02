import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_dismiss_barrier.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController mapController;
  late final TileProvider tileProvider;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    tileProvider = CancellableNetworkTileProvider();
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
        BlocConsumer<MapBloc, MapState>(
          listenWhen: (previous, current) {
            return previous.failure != current.failure &&
                current.failure != null;
          },
          listener: (context, state) {
            final failure = state.failure!;
            context.read<AppBannerCubit>().showFailure(failure);
            context.read<MapBloc>().add(MapStarted());
          },
          buildWhen: (previous, current) =>
              previous.locations != current.locations ||
              previous.selectedLocation != current.selectedLocation,
          builder: (context, state) {
            debugPrint("map call blocconsumer");
            return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: state.center,
                initialZoom: state.zoom,
                onMapReady: () {
                  context.read<MapBloc>().add(MapStarted());
                },
                onMapEvent: (event) {
                  if (event is MapEventMoveEnd ||
                      event is MapEventDoubleTapZoomEnd) {
                    final bounds = mapController.camera.visibleBounds;
                    debugPrint("Bounds changed: $bounds");
                    context.read<MapBloc>().add(
                      MapBoundsChanged(bounds: bounds),
                    );
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  tileProvider: tileProvider,
                  userAgentPackageName: 'de.jarovart.casttime',
                ),
                MarkerLayer(
                  markers: state.locations.map((location) {
                    return Marker(
                      point: location.position,
                      width: 48,
                      height: 48,
                      child: GestureDetector(
                        onTap: () {
                          context.read<MapBloc>().add(
                            MapLocationSelected(location),
                          );
                        },
                        child: const Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (state.status == LocationLoadStatus.loading)
                  const Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: Center(child: CircularProgressIndicator()),
                  ),

                if (state.selectedLocation != null)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Text("selected") /*LocationBottomSheet(
                    location: state.selectedLocation!,
                    onClose: () {
                      context.read<MapBloc>().add(MapLocationDeselected());
                    },
                  ),*/,
                  ),
              ],
            );
          },
        ),
        const SearchDismissBarrier(),
        MapSearchOverlay(dockWidth: dockWidth),
      ],
    );
  }
}
