import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/banner/appbottom_banner.dart';
import 'package:casttime/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_state.dart';
import 'package:casttime/features/map/presentation/widgets/map_day_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(BuildContext context, int index) {
    bool isReclicked = index == navigationShell.currentIndex;

    if (index == 0 && isReclicked) {
      // enum adding
      debugPrint("map center function");
      context.read<MapBloc>().add(MapCenterOnUserRequested());
      return;
    }

    navigationShell.goBranch(index, initialLocation: isReclicked);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    //final isWide = width >= 430;
    final dockWidth = width >= 700 ? 520.0 : width - 24;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          navigationShell,
          _MapSearchBar(dockWidth: dockWidth),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: dockWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surface.withValues(alpha: 0.66),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: colors.outlineVariant),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const AppBottomBanner(),
                      _CollapsibleFilterBar(
                        visible: navigationShell.currentIndex == 0,
                      ),
                      NavigationBar(
                        selectedIndex: navigationShell.currentIndex,
                        onDestinationSelected: (index) =>
                            _onDestinationSelected(context, index),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        height: 64,
                        indicatorColor: colors.primary.withValues(alpha: 0.16),
                        labelBehavior:
                            NavigationDestinationLabelBehavior.onlyShowSelected,
                        destinations: const [
                          NavigationDestination(
                            icon: Icon(Icons.map_outlined),
                            selectedIcon: Icon(Icons.map),
                            label: 'Map',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.explore_outlined),
                            selectedIcon: Icon(Icons.explore),
                            label: 'For You1',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.add_circle_outline),
                            selectedIcon: Icon(Icons.add_circle),
                            label: 'Erstellen',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.location_on_outlined),
                            selectedIcon: Icon(Icons.location_on),
                            label: 'Meine',
                          ),
                          NavigationDestination(
                            icon: Icon(Icons.person_outline),
                            selectedIcon: Icon(Icons.person),
                            label: 'Profil',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MapSlider extends StatelessWidget {
  const _MapSlider();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final l10n = context.l10n;

    final dayOptions = [
      l10n.today,
      l10n.tomorrow,
      l10n.dayAfterTomorrow,
      l10n.nextWeek,
      l10n.nextMonth,
    ];

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        showValueIndicator: ShowValueIndicator.never,
        activeTrackColor: theme.iconTheme.color,
        inactiveTrackColor: colors.secondary.withValues(alpha: 0.3),
        thumbColor: colors.primary,
        overlayColor: colors.primary.withValues(alpha: 0.15),
        valueIndicatorColor: theme.cardTheme.color!.withValues(alpha: 0.2),
        valueIndicatorTextStyle: TextStyle(color: colors.primary),
        trackHeight: 2,
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 8,
        ),
      ),
      child: BlocBuilder<MapBloc, MapState>(
        buildWhen: (p, c) =>
            p.startDate != c.startDate || p.endDate != c.endDate,
        builder: (context, state) {
          // TODO: startDate/endDate -> Index, sobald dayOptions bekannt ist
          final startIndex = state.rangeValues.start;
          final endIndex = state.rangeValues.end;

          return RangeSlider(
            values: RangeValues(startIndex, endIndex),
            min: 0,
            max: (dayOptions.length - 1).toDouble(),
            divisions: dayOptions.length - 1,
            labels: RangeLabels(
              dayOptions[startIndex.toInt()],
              dayOptions[endIndex.toInt()],
            ),
            onChanged: (values) {
              // onChangeEnd statt onChanged: feuert erst beim Loslassen,
              // damit während des Ziehens kein Request pro Frame rausgeht.
              final start = dateFromDayOptionIndex(values.start.round());
              final end = dateFromDayOptionIndex(values.end.round());
              final mapBloc = context.read<MapBloc>();
              context.read<MapBloc>().add(
                MapSliderChanged(
                  bounds: state.bounds,
                  rangeValues: values,
                  startDate: start,
                  endDate: end,
                ),
              );
              // snap to discrete steps
              /*final start = values.start.roundToDouble();
          final end = values.end.roundToDouble();
          mapViewController.setDateRange(RangeValues(start, end));

          mapViewController.debouncer.run(
            () => mapBloc.add(MapSliderChanged()),
          );*/
            },
          );
        },
      ),
    );
  }
}

class _MapSearchBar extends StatefulWidget {
  const _MapSearchBar({required this.dockWidth});
  final double dockWidth;

  @override
  State<_MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<_MapSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() => _isFocused = _focusNode.hasFocus);
      });
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

  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.15;
    final topOffset = 15.0;
    final mapBloc = context.watch<MapBloc>();
    final dockWidth = widget.dockWidth;

    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: dockWidth,
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AnimatedContainer(
              width: dockWidth,
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: _isFocused
                    ? colors.surface.withValues(alpha: 0.95)
                    : colors.surfaceContainerHighest.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _isFocused
                      ? colors.primary
                      : colors.outline.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: _isFocused
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: BlocBuilder<MapBloc, MapState>(
                    buildWhen: (prev, curr) =>
                        prev.searchQuery != curr.searchQuery,
                    builder: (context, state) {
                      if (_controller.text != state.searchQuery &&
                          !_focusNode.hasFocus) {
                        _controller.text = state.searchQuery;
                      }
                      return TextField(
                        focusNode: _focusNode,
                        controller: _controller,
                        onChanged: (value) => context.read<MapBloc>().add(
                          MapSearchChanged(value),
                        ),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: context.l10n.searching,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: colors.onSurfaceVariant,
                          ),
                          suffixIcon: state.searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: colors.onSurfaceVariant,
                                  ),
                                  onPressed: _close,
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        style: TextStyle(color: colors.onSurface),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DateRangeLabel extends StatelessWidget {
  const _DateRangeLabel();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dayOptions = [
      l10n.today,
      l10n.tomorrow,
      l10n.dayAfterTomorrow,
      l10n.nextWeek,
      l10n.nextMonth,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: SizedBox(
        height: 24,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<MapBloc, MapState>(
              buildWhen: (p, c) =>
                  p.startDate != c.startDate || p.endDate != c.endDate,
              builder: (context, state) {
                return Row(
                  children: [
                    Text(
                      dayOptions[state.rangeValues.start.toInt()],
                    ), // TODO: eure Formatierung
                    const Spacer(),
                    Text(dayOptions[state.rangeValues.end.toInt()]),
                  ],
                );
              },
            ),
            Text(
              AppConfig.appName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollapsibleFilterBar extends StatelessWidget {
  const _CollapsibleFilterBar({required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: visible ? 1 : 0,
        child: visible
            ? const Column(
                mainAxisSize: MainAxisSize.min,
                children: [_DateRangeLabel(), _MapSlider()],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
