import 'package:casttime/app/navigation/model/nav_destination.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/pages/profile_nav_icon.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/widgets/mapslider/map_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppNavigation {
  static List<NavDestination> _editActions({
    required NavAction onCancel,
    required NavAction onReset,
    required NavAction onSave,
  }) => [
    NavDestination(
      id: 'cancel',
      labelBuilder: (l10n) => l10n.returnTitle,
      icon: Icons.close,
      onSelected: onCancel,
    ),
    NavDestination(
      id: 'reset',
      labelBuilder: (l10n) => l10n.reset,
      icon: Icons.restart_alt,
      onSelected: onReset,
    ),
    NavDestination(
      id: 'save',
      labelBuilder: (l10n) => l10n.save,
      icon: Icons.check,
      onSelected: onSave,
    ),
  ];

  static final List<NavDestination> destinations = [
    NavDestination(
      id: 'map',
      labelBuilder: (l10n) => l10n.mapTitle,
      icon: Icons.map_outlined,
      selectedIcon: Icons.map,
      routePath: RouteConfig.mapUrl,
      branchIndex: 0,
      onReselected: _centerOnGps,
      extraContent: (context) => const MapSlider(),
    ),
    NavDestination(
      id: 'forYou',
      labelBuilder: (l10n) => l10n.forYouTitle,
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore,
      routePath: RouteConfig.locationListUrl,
      extraMatchPaths: const ['/profile'],
      branchIndex: 1,
    ),
    NavDestination(
      id: 'create',
      labelBuilder: (l10n) => l10n.createTitle,
      icon: Icons.add_circle_outline,
      selectedIcon: Icons.add_circle,
      routePath: RouteConfig.createLocationUrl,
      branchIndex: 2,
      onSelected: (context) {
        final mapState = context.read<MapBloc>().state;
        final center = mapState.currentPosition ?? mapState.bounds.center;
        context.go(
          RouteConfig.getLocationCreateUrl(
            lat: center.latitude,
            lng: center.longitude,
          ),
        );
      },
      requiresAuth: true,
      replacesBar: true,
      usesEditBar: true,
    ),
    NavDestination(
      id: 'myLocations',
      labelBuilder: (l10n) => l10n.myLocationsTitle,
      icon: Icons.location_on_outlined,
      selectedIcon: Icons.location_on,
      routePath: '/my-locations',
      branchIndex: 3,
      requiresAuth: true,
    ),
    NavDestination(
      id: 'profile',
      labelBuilder: (l10n) => l10n.myProfileTitle,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      customIcon: _profileIcon,
      routePath: RouteConfig.myProfileUrl,
      branchIndex: 4,
      requiresAuth: true,
      children: [
        NavDestination(
          id: 'login',
          labelBuilder: (l10n) => l10n.logout,
          icon: Icons.logout,
          //routePath: RouteConfig.loginUrl,
          onSelected: _logout,
          visibleWhen: _loggedIn,
        ),
        NavDestination(
          id: 'info',
          labelBuilder: (l10n) => l10n.info,
          icon: Icons.info_outline,
          routePath: RouteConfig.infoUrl,
        ),
        NavDestination(
          id: 'support',
          labelBuilder: (l10n) => l10n.support,
          icon: Icons.support_agent_outlined,
          routePath: RouteConfig.supportUrl,
        ),
        NavDestination(
          id: 'friends',
          labelBuilder: (l10n) => l10n.users,
          icon: Icons.people_outline,
          routePath: RouteConfig.userListUrl,
          visibleWhen: _loggedIn,
          requiresAuth: true,
        ),
        NavDestination(
          id: 'settings',
          labelBuilder: (l10n) => l10n.settings,
          icon: Icons.settings_outlined,
          routePath: RouteConfig.settingsUrl,
        ),
        NavDestination(
          id: 'edit',
          labelBuilder: (l10n) => l10n.editProfile,
          icon: Icons.edit_outlined,
          routePath: RouteConfig.editProfileUrl,
          visibleWhen: _loggedIn,
          requiresAuth: true,
          replacesBar: true,
          usesEditBar: true,
        ),
      ],
    ),
  ];

  // ── Sichtbarkeit ───────────────────────────────────────
  static bool _loggedIn(NavContext ctx) => ctx.isLoggedIn;

  // ── Darstellung ────────────────────────────────────────
  static Widget _profileIcon(bool selected) =>
      ProfileNavIcon(selected: selected);

  // ── Aktionen ───────────────────────────────────────────
  static void _centerOnGps(BuildContext context) =>
      context.read<MapBloc>().add(MapGeoLocationChanged());

  static void _backToProfile(BuildContext context) =>
      context.go(RouteConfig.myProfileUrl);

  static void _resetForm(BuildContext context) =>
      debugPrint('reset editprofile');

  static void _saveForm(BuildContext context) => debugPrint('save editprofile');

  static void _logout(BuildContext context) {
    context.read<AuthCubit>().logout();
    //context.go(RouteConfig.loginUrl);
  }

  // ── Ableitung aus der URL ──────────────────────────────

  /// Tiefste Kette, deren letzter Knoten auf [location] passt.
  /// Eltern müssen selbst nicht matchen — so dürfen Unterpunkte
  /// eigene, frei gewählte Pfade haben.
  static List<NavDestination> chainForLocation(
    String location, {
    int? fallbackBranchIndex,
  }) {
    List<NavDestination> search(List<NavDestination> level) {
      var best = <NavDestination>[];

      for (final node in level) {
        final deeper = search(node.children);
        if (deeper.isNotEmpty) {
          final candidate = [node, ...deeper];
          if (candidate.length > best.length) best = candidate;
        } else if (node.matches(location) && best.isEmpty) {
          best = [node];
        }
      }
      return best;
    }

    final result = search(destinations);
    if (result.isNotEmpty) return result;

    final fallback = destinations
        .where((d) => d.branchIndex == fallbackBranchIndex)
        .firstOrNull;
    return [fallback ?? destinations.first];
  }

  /// Alle login-pflichtigen Pfade — Futter für den Router-Guard.
  static final List<String> protectedPaths = _collectProtected(destinations);

  static List<String> _collectProtected(List<NavDestination> nodes) => [
    for (final d in nodes) ...[
      if (d.requiresAuth && d.routePath != null) d.routePath!,
      ..._collectProtected(d.children),
    ],
  ];

  static bool isProtected(String location) =>
      protectedPaths.any((p) => location == p || location.startsWith('$p/'));
}
