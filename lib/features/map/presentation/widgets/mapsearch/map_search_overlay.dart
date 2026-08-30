import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_deco.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_results_list.dart';
import 'package:casttime/features/map/presentation/widgets/mapsearch/map_search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapSearchOverlay extends StatefulWidget {
  const MapSearchOverlay({required this.dockWidth});
  final double dockWidth;

  @override
  State<MapSearchOverlay> createState() => MapSearchOverlayState();
}

class MapSearchOverlayState extends State<MapSearchOverlay> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final Widget _searchField;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() => _isFocused = _focusNode.hasFocus);
      });

    _searchField = SearchTextField(
      controller: _controller,
      focusNode: _focusNode,
      onClose: _close,
    );
  }

  void _selectLocation(Location location) {
    context.read<MapBloc>()
      ..add(MapSearchChanged('')) //TODO remove
      ..add(MapLocationSelected(location));

    _focusNode.unfocus();
  }

  void _close() {
    _controller.clear();
    _focusNode.unfocus();
    context.read<MapBloc>().add(MapSearchChanged(''));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dockWidth = widget.dockWidth;
    debugPrint("map search");

    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: dockWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedSearchDecoration(
                  isFocused: _isFocused,
                  dockWidth: dockWidth,
                  // Wird EINMAL gebaut, als Objekt an den Decoration-Wrapper
                  // durchgereicht. Ändert sich _isFocused, baut NUR
                  // _AnimatedSearchDecoration.build() neu (rein deko-mäßig) –
                  // dieses child-Objekt hier wird nicht neu konstruiert,
                  // solange sich searchQuery nicht ändert.
                  child: _searchField,
                ),
                const SizedBox(height: 8),
                SearchResultsList(onLocationTap: _selectLocation),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
