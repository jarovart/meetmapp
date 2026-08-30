import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/location/domain/model/location.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({required this.onLocationTap});

  final ValueChanged<Location> onLocationTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (prev, curr) =>
          prev.searchQuery != curr.searchQuery ||
          prev.searchLocations != curr.searchLocations ||
          prev.status != curr.status,
      builder: (context, state) {
        final showResults = state.searchQuery.isNotEmpty;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: -1,
              child: child,
            ),
          ),
          child: !showResults
              ? const SizedBox.shrink(key: ValueKey('empty'))
              : SizedBox(
                  key: const ValueKey('results'),
                  width: double.infinity,
                  child: _ResultsCard(
                    state: state,
                    onLocationTap: onLocationTap,
                  ),
                ),
        );
      },
    );
  }
}

class _ResultsCard extends StatelessWidget {
  const _ResultsCard({
    super.key,
    required this.state,
    required this.onLocationTap,
  });

  final MapState state;
  final ValueChanged<Location> onLocationTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(maxHeight: 340),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: switch (state.status) {
        LoadStatus.loading when state.searchLocations.isEmpty => _LoadingState(
          colors: colors,
        ),
        LoadStatus.success when state.searchLocations.isEmpty => _EmptyState(
          colors: colors,
          query: state.searchQuery,
        ),
        LoadStatus.failure => _ErrorState(colors: colors),
        _ => _ResultsListView(
          locations: state.searchLocations,
          isRefreshing: state.status == LoadStatus.loading,
          onLocationTap: onLocationTap,
        ),
      },
    );
  }
}

class _ResultsListView extends StatelessWidget {
  const _ResultsListView({
    required this.locations,
    required this.isRefreshing,
    required this.onLocationTap,
  });

  final List<Location> locations;
  final bool isRefreshing;
  final ValueChanged<Location> onLocationTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dünner Ladebalken, falls im Hintergrund neu gesucht wird,
        // während noch die alten Ergebnisse sichtbar sind (kein
        // kompletter Content-Swap -> fühlt sich flüssiger an).
        AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: isRefreshing ? 1 : 0,
          child: LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: Colors.transparent,
            color: colors.primary,
          ),
        ),
        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 4),
            shrinkWrap: true,
            itemCount: locations.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              indent: 60,
              color: colors.outline.withValues(alpha: 0.15),
            ),
            itemBuilder: (context, index) {
              final location = locations[index];
              return _SearchResultTile(
                location: location,
                index: index,
                onTap: () => onLocationTap(location),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({
    required this.location,
    required this.index,
    required this.onTap,
  });

  final Location location;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // Leichtes, gestaffeltes Einfliegen der Zeilen – rein kosmetisch,
    // keine Package-Abhängigkeit, nur TweenAnimationBuilder.
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 200 + (index * 40).clamp(0, 200)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 8),
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.place_outlined,
                  size: 20,
                  color: colors.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      location.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                    if (location.address != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        location.address!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: colors.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState({required this.colors});
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.colors, required this.query});
  final ColorScheme colors;
  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 28, color: colors.onSurfaceVariant),
          const SizedBox(height: 8),
          Text(
            context.l10n.searchNoLocationsTitle,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.searchNoLocationsDescription,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.colors});
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 28, color: colors.error),
          const SizedBox(height: 8),
          Text(
            context.l10n.errorSearch,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
