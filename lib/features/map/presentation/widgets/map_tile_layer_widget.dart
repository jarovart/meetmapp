// features/map/presentation/widgets/app_tile_layer.dart
import 'package:casttime/app/config/app_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

class AppTileLayer extends StatelessWidget {
  const AppTileLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      tileProvider: CancellableNetworkTileProvider(),
      userAgentPackageName: AppConfig.packageName,
    );
  }
}
