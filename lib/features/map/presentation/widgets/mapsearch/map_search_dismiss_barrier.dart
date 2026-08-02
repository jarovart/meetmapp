import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDismissBarrier extends StatelessWidget {
  const SearchDismissBarrier();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (prev, curr) => prev.searchQuery != curr.searchQuery,
      builder: (context, state) {
        final active = state.searchQuery.isNotEmpty;

        // IgnorePointer(ignoring: true) sorgt dafür, dass die Karte bei
        // geschlossener Suche ganz normal Pan/Zoom/Marker-Taps bekommt –
        // die Barriere existiert dann nur "auf dem Papier", ohne
        // Pointer-Events abzufangen.
        return IgnorePointer(
          ignoring: !active,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Kein Zugriff auf die konkrete FocusNode-Instanz nötig:
              // primaryFocus zeigt auf das aktuell fokussierte Widget
              // im gesamten Baum – hier ist das ohnehin nur das Suchfeld.
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<MapBloc>().add(MapSearchChanged(''));
            },
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}
