import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/location/domain/serviceinterface/location_service.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/location_create_event.dart';
import 'package:casttime/features/map/presentation/widgets/map_tile_layer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PositionPicker extends StatefulWidget {
  const PositionPicker({required this.position, required this.enabled});

  final LatLng? position;
  final bool enabled;

  @override
  State<PositionPicker> createState() => _PositionPickerState();
}

class _PositionPickerState extends State<PositionPicker> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final position = widget.position;
    debugPrint('submit positionpicker=$position');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.position, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 220,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: position ?? const LatLng(51.1657, 10.4515),
                    initialZoom: position == null ? 6 : 15,
                    onMapEvent: (event) {
                      if (event is! MapEventMoveEnd) return;

                      const userSources = {
                        MapEventSource.dragEnd,
                        MapEventSource.flingAnimationController,
                        MapEventSource.doubleTapZoomAnimationController,
                        MapEventSource.multiFingerEnd,
                        MapEventSource.scrollWheel,
                      };
                      if (!userSources.contains(event.source)) return;

                      context.read<LocationCreateBloc>().add(
                        LocationPositionChanged(_mapController.camera.center),
                      );
                    },
                  ),
                  children: [const AppTileLayer()],
                ),
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Icon(Icons.place, size: 48, color: colors.primary),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: FloatingActionButton.small(
                    heroTag: 'create_my_location',
                    onPressed: widget.enabled ? _centerOnCurrentPosition : null,
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (position != null) _CoordinateRow(position: position),
      ],
    );
  }

  Future<void> _centerOnCurrentPosition() async {
    final result = await getIt<LocationService>().getCurrentPosition();
    if (!mounted) return;

    if (result case Success<LatLng>(:final data)) {
      _mapController.move(data, 15);
    }
  }
}

class _CoordinateRow extends StatelessWidget {
  const _CoordinateRow({required this.position});

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _copyToClipboard(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(Icons.place_outlined, size: 20, color: colors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.positionWithCoordinates(
                    position.latitude,
                    position.longitude,
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Icon(Icons.copy, size: 18, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);

    await Clipboard.setData(
      ClipboardData(text: '${position.latitude}, ${position.longitude}'),
    );

    messenger.showSnackBar(SnackBar(content: Text(l10n.positionCopied)));
  }
}
