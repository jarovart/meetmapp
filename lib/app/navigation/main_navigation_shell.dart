import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/navigation/widgets/bottom_bar_extension.dart';
import 'package:casttime/app/presentation/banner/appbottom_banner.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/cubit/pages/profile_nav_icon.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(BuildContext context, int index) {
    bool isReclicked = index == navigationShell.currentIndex;

    if (index == 0 && isReclicked) {
      // enum adding
      debugPrint("map center function");
      context.read<MapBloc>().add(MapGeoLocationChanged());
      return;
    }
    const profileTabIndex = 4;
    if (index == profileTabIndex) {
      final isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
      if (!isLoggedIn) {
        context.go(RouteConfig.loginUrl);
        return;
      } else {
        context.go(
          RouteConfig.profileUrl,
          extra: context.read<AuthCubit>().state.userId,
        );
      }
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
    debugPrint("main_navigationsshell");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(children: [navigationShell]),
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
                      BottomBarExtension(
                        currentIndex: navigationShell.currentIndex,
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
                            icon: ProfileNavIcon(),
                            selectedIcon: ProfileNavIcon(selected: true),
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
