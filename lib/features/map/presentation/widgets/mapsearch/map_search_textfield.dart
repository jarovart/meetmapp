import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.controller,
    required this.focusNode,
    required this.onClose,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    debugPrint("map search bloc");
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (prev, curr) => prev.searchQuery != curr.searchQuery,
      builder: (context, state) {
        debugPrint("map search blocconsumer");
        if (controller.text != state.searchQuery && !focusNode.hasFocus) {
          controller.text = state.searchQuery;
        }
        return TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: (value) =>
              context.read<MapBloc>().add(MapSearchChanged(value)),
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: context.l10n.searching,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: colors.onSurfaceVariant),
            suffixIcon: state.searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.close, color: colors.onSurfaceVariant),
                    onPressed: onClose,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          ),
          style: TextStyle(color: colors.onSurface),
        );
      },
    );
  }
}
