import 'package:casttime/extensions/l10n_extension.dart';
import 'package:casttime/program/core/failure/appfailurelocalisation.dart';
import 'package:casttime/program/presentation/bloc/mapbloc.dart';
import 'package:casttime/program/presentation/bloc/mapevent.dart';
import 'package:casttime/program/presentation/bloc/mapstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();

    return Scaffold(
      body: BlocConsumer<MapBloc, MapState>(
        listenWhen: (previous, current) {
          return previous.failure != current.failure && current.failure != null;
        },
        listener: (context, state) {
          final failure = state.failure!;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(failure.localizedMessage(context.l10n))),
            );
          context.read<MapBloc>().add(MapStarted());
        },
        builder: (context, state) {
          return Stack(
            children: [
              FlutterMap(
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
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    tileProvider: CancellableNetworkTileProvider(),
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
                          child: const Icon(Icons.location_on, size: 40),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),

              Positioned(
                top: MediaQuery.of(context).padding.top + 12,
                left: 16,
                right: 16,
                child: SearchBar(
                  hintText: 'Suche',
                  onChanged: (value) {
                    context.read<MapBloc>().add(MapSearchChanged(value));
                  },
                ),
              ),

              Positioned(
                right: 16,
                bottom: 120,
                child: FloatingActionButton.small(
                  onPressed: () {
                    context.read<MapBloc>().add(MapCenterOnUserRequested());
                  },
                  child: const Icon(Icons.my_location),
                ),
              ),

              if (state.isLoading)
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
    );
  }
}
