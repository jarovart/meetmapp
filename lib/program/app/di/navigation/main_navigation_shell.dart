import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/controller/auth_controller.dart';
import 'package:casttime/app/controller/map_controller.dart';
import 'package:casttime/extensions/l10n_extension.dart';
import 'package:casttime/program/app/di/appbottom_banner.dart';
import 'package:casttime/program/presentation/bloc/mapbloc.dart';
import 'package:casttime/program/presentation/bloc/mapevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(BuildContext context, int index) {
    bool isReclicked = index == navigationShell.currentIndex;
    bool isMapAlreadyOpen = index == 0 && isReclicked;

    if (isMapAlreadyOpen) {
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
    final authController = context.watch<AuthController>();
    final mapViewController = context.watch<MapViewController>();
    final isLoggedIn = authController.isLoggedIn;

    final isWide = width >= 430;
    final dockWidth = width >= 700 ? 520.0 : width - 24;
    /*final pages = [
      const MapPage(),
      const LocationsListPage(), // mylocation später ersetzen
      const LocationsListPage(),
      const UserListPage(), // search/discover
      authController.isLoggedIn
          ? const UserProfilePage()
          : LoginPage(
              loginController: LoginController(),
              authController: authController,
            ),
    ];*/

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          navigationShell,
          _buildSearchBar(context, mapViewController, dockWidth),
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
                      AppBottomBanner(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 4,
                        ),
                        child: SizedBox(
                          height: 24,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    mapViewController.setDayOptionsText(
                                      mapViewController.selectedRange.start,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    mapViewController.setDayOptionsText(
                                      mapViewController.selectedRange.end,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                AppConfig.appName,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      slider(context),

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

  Widget _buildSearchBar(
    BuildContext context,
    MapViewController mapViewController,
    double dockWidth,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final sidePadding = screenWidth * 0.15;
    final topOffset = 15.0;
    final searchController = mapViewController.searchController;
    final isFocused = mapViewController.searchFocusNode.hasFocus;

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
                color: isFocused
                    ? colors.surface.withValues(alpha: 0.95)
                    : colors.surfaceContainerHighest.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isFocused
                      ? colors.primary
                      : colors.outline.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: isFocused
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
                  child: TextField(
                    focusNode: mapViewController.searchFocusNode,
                    controller: searchController,
                    onChanged: mapViewController.onSearchChanged,
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
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: colors.onSurfaceVariant,
                              ),
                              onPressed: mapViewController.closeSearch,
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                      ),
                    ),
                    style: TextStyle(color: colors.onSurface),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget slider(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final mapViewController = context.watch<MapViewController>();

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
      child: RangeSlider(
        values: mapViewController.selectedRange,
        min: 0,
        max: (mapViewController.dayOptions.length - 1).toDouble(),
        divisions: mapViewController.dayOptions.length - 1,
        labels: RangeLabels(
          mapViewController.setDayOptionsText(
            mapViewController.selectedRange.start,
          ),
          mapViewController.setDayOptionsText(
            mapViewController.selectedRange.end,
          ),
        ),
        onChanged: (values) {
          // snap to discrete steps
          final start = values.start.roundToDouble();
          final end = values.end.roundToDouble();
          mapViewController.setDateRange(RangeValues(start, end));

          mapViewController.debouncer.run(
            () => mapViewController.fetchLocations(),
          );
        },
      ),
    );
  }
}
