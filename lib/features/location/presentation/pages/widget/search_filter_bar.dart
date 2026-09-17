import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_event.dart';
import 'package:casttime/features/location/presentation/pages/location_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndFilterBar extends StatefulWidget {
  const SearchAndFilterBar();

  @override
  State<SearchAndFilterBar> createState() => _SearchAndFilterBarState();
}

class _SearchAndFilterBarState extends State<SearchAndFilterBar> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                onChanged: (value) => context.read<LocationSearchBloc>().add(
                  LocationSearchQueryChanged(value),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => context.read<LocationSearchBloc>().add(
                  LocationSearchSubmitted(),
                ),
                decoration: InputDecoration(
                  hintText: l10n.searching,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _searchCtrl.clear();
                            context.read<LocationSearchBloc>().add(
                              LocationSearchCleared(),
                            );
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Material(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => LocationFilterDialog.show(context),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.tune),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
