import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/app/presentation/widget/centered_message.dart';
import 'package:casttime/features/location/presentation/bloc/my_locations_bloc.dart';
import 'package:casttime/features/location/presentation/bloc/my_locations_event.dart';
import 'package:casttime/features/location/presentation/bloc/my_locations_state.dart';
import 'package:casttime/features/location/presentation/widgets/my_location_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyLocationsPage extends StatelessWidget {
  const MyLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyLocationsBloc>()..add(MyLocationsRequested()),
      child: const _MyLocationsView(),
    );
  }
}

class _MyLocationsView extends StatelessWidget {
  const _MyLocationsView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MyLocationsHeader(),
        Expanded(
          child: BlocBuilder<MyLocationsBloc, MyLocationsState>(
            builder: (context, state) => _MyLocationsBody(state: state),
          ),
        ),
      ],
    );
  }
}

class _MyLocationsBody extends StatelessWidget {
  const _MyLocationsBody({required this.state});

  final MyLocationsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (state.status == LoadStatus.loading && state.locations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == LoadStatus.failure && state.locations.isEmpty) {
      return CenteredMessage(
        message:
            state.failure?.localizedMessage(l10n) ?? l10n.errorCallLocations,
        isError: true,
        onRetry: () =>
            context.read<MyLocationsBloc>().add(MyLocationsRequested()),
      );
    }

    if (state.locations.isEmpty) {
      return CenteredMessage(message: l10n.noJoinedLocations);
    }

    return RefreshIndicator(
      onRefresh: () async =>
          context.read<MyLocationsBloc>().add(MyLocationsRequested()),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification ||
              notification is OverscrollNotification) {
            if (notification.metrics.extentAfter < 300) {
              context.read<MyLocationsBloc>().add(
                MyLocationsLoadMoreRequested(),
              );
            }
          }
          return false;
        },
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            AppConfig.maxNavigationDockBarHeight,
          ),
          itemCount: state.locations.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= state.locations.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final location = state.locations[index];
            final bloc = context.read<MyLocationsBloc>();

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppConfig.maxAppWidth,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MyLocationCard(
                    location: location,
                    isLeaving: state.pendingRemovalIds.contains(location.id),
                    onTap: () => context.push(
                      RouteConfig.getLocationUrl(location.id),
                      extra: location,
                    ),
                    onLikeTap: () =>
                        bloc.add(MyLocationLikeToggled(location.id)),
                    onJoinTap: () =>
                        bloc.add(MyLocationJoinToggled(location.id)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MyLocationsHeader extends StatelessWidget {
  const _MyLocationsHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppConfig.maxAppWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Text(
            l10n.myLocationsTitle,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
