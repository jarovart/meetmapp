import 'package:casttime/app/navigation/model/nav_destination.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavRow extends StatelessWidget {
  const NavRow({
    super.key,
    required this.destinations,
    required this.activeChain,
    required this.isRoot,
    required this.navigationShell,
  });

  final List<NavDestination> destinations;
  final List<NavDestination> activeChain;
  final bool isRoot;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final selectedIndex = destinations.indexWhere(activeChain.contains);
    final hasSelection = selectedIndex >= 0;

    return NavigationBar(
      selectedIndex: hasSelection ? selectedIndex : 0,
      onDestinationSelected: (index) => _onTap(
        context,
        destinations[index],
        isReselected: index == selectedIndex,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      height: isRoot ? 64 : 52,
      indicatorColor: hasSelection
          ? colors.primary.withValues(alpha: 0.16)
          : Colors.transparent,
      labelBehavior: isRoot
          ? NavigationDestinationLabelBehavior.onlyShowSelected
          : NavigationDestinationLabelBehavior.alwaysHide,
      destinations: [
        for (final d in destinations)
          NavigationDestination(
            icon:
                d.customIcon?.call(false) ??
                Icon(d.icon, color: colors.primary),
            selectedIcon:
                d.customIcon?.call(true) ??
                Icon(d.selectedIcon ?? d.icon, color: colors.primary),
            label: d.label,
            tooltip: d.label,
          ),
      ],
    );
  }

  void _onTap(
    BuildContext context,
    NavDestination destination, {
    required bool isReselected,
  }) {
    if (isReselected && destination.onReselected != null) {
      destination.onReselected!(context);
      return;
    }

    destination.onSelected?.call(context);

    if (destination.branchIndex != null) {
      navigationShell.goBranch(
        destination.branchIndex!,
        initialLocation: isReselected,
      );
    } else if (destination.routePath != null) {
      context.go(destination.routePath!);
    }
  }
}
