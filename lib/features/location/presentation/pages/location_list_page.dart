import 'dart:math';

import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_event.dart';
import 'package:casttime/features/location/presentation/bloc/locationlist_state.dart';
import 'package:casttime/features/location/presentation/pages/widget/location_card.dart';
import 'package:casttime/features/location/presentation/pages/widget/search_filter_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsListPage extends StatelessWidget {
  const LocationsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LocationSearchBloc>()..add(LocationSearchStarted()),
      child: const _LocationsListView(),
    );
  }
}

class _LocationsListView extends StatelessWidget {
  const _LocationsListView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Stack(
      children: [
        BlocBuilder<LocationSearchBloc, LocationSearchState>(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.locations != current.locations ||
              previous.isLoadingMore != current.isLoadingMore,
          builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == LoadStatus.failure && state.locations.isEmpty) {
              return Center(
                child: Text(
                  state.failure?.localizedMessage(l10n) ??
                      l10n.errorCallLocations,
                ),
              );
            }
            if (state.locations.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async => context.read<LocationSearchBloc>().add(
                  LocationSearchSubmitted(),
                ),
                child: ListView(
                  children: [
                    const SizedBox(height: 200),
                    Center(
                      child: Text(
                        state.query.length <= 3
                            ? l10n.useSearch
                            : l10n.noLocationsFound,
                      ),
                    ),
                  ],
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                const headerHeight = 60.0;
                final crossAxisCount = max(1, constraints.maxWidth ~/ 400);

                return RefreshIndicator(
                  onRefresh: () async => context.read<LocationSearchBloc>().add(
                    LocationSearchSubmitted(),
                  ),
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification ||
                          notification is OverscrollNotification) {
                        if (notification.metrics.extentAfter < 300) {
                          context.read<LocationSearchBloc>().add(
                            LocationSearchLoadMoreRequested(),
                          );
                        }
                      }
                      return false;
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        16 + headerHeight,
                        16,
                        16,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        mainAxisExtent: 300,
                      ),
                      itemCount:
                          state.locations.length +
                          (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.locations.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return LocationCard(location: state.locations[index]);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        const SearchAndFilterBar(),
      ],
    );
  }
}
