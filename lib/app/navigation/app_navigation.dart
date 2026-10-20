import 'package:casttime/app/navigation/model/nav_destination.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/features/auth/presentation/cubit/pages/profile_nav_icon.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/features/map/presentation/bloc/map_event.dart';
import 'package:casttime/features/map/presentation/widgets/mapslider/map_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract final class AppNavigation {
  static final List<NavDestination> destinations = [
    NavDestination(
      id: 'map',
      label: 'Map',
      icon: Icons.map_outlined,
      selectedIcon: Icons.map,
      routePath: RouteConfig.mapUrl,
      branchIndex: 0,
      onReselected: _centerOnGps,
      extraContent: (context) => const MapSlider(),
    ),
    NavDestination(
      id: 'forYou',
      label: 'For You',
      icon: Icons.explore_outlined,
      selectedIcon: Icons.explore,
      routePath: RouteConfig.locationListUrl,
      extraMatchPaths: const ['/profile'],
      branchIndex: 1,
    ),
    NavDestination(
      id: 'create',
      label: 'Erstellen',
      icon: Icons.add_circle_outline,
      selectedIcon: Icons.add_circle,
      routePath: '/create-location',
      branchIndex: 2,
    ),
    NavDestination(
      id: 'myLocations',
      label: 'Meine',
      icon: Icons.location_on_outlined,
      selectedIcon: Icons.location_on,
      routePath: '/my-locations',
      branchIndex: 3,
    ),
    NavDestination(
      id: 'profile',
      label: 'Profil',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      customIcon: _profileIcon,
      routePath: RouteConfig.myProfileUrl,
      branchIndex: 4,
      requiresAuth: true,
      children: [
        NavDestination(
          id: 'login',
          label: 'Anmelden',
          icon: Icons.login,
          routePath: RouteConfig.loginUrl,
          visibleWhen: _loggedOut,
        ),
        NavDestination(
          id: 'info',
          label: 'Info',
          icon: Icons.info_outline,
          routePath: RouteConfig.infoUrl,
        ),
        NavDestination(
          id: 'support',
          label: 'Support',
          icon: Icons.support_agent_outlined,
          routePath: RouteConfig.supportUrl,
        ),
        NavDestination(
          id: 'friends',
          label: 'Freunde',
          icon: Icons.people_outline,
          routePath: RouteConfig.friendsUrl,
          requiresAuth: true,
        ),
        NavDestination(
          id: 'settings',
          label: 'Einstellungen',
          icon: Icons.settings_outlined,
          routePath: RouteConfig.settingsUrl,
        ),
        NavDestination(
          id: 'edit',
          label: 'Bearbeiten',
          icon: Icons.edit_outlined,
          routePath: RouteConfig.editProfileUrl,
          requiresAuth: true,
          replacesBar: true,
          children: [
            NavDestination(
              id: 'back',
              label: 'Zurück',
              icon: Icons.arrow_back,
              onSelected: _backToProfile,
            ),
            NavDestination(
              id: 'reset',
              label: 'Reset',
              icon: Icons.restart_alt,
              onSelected: _resetForm,
            ),
            NavDestination(
              id: 'save',
              label: 'Speichern',
              icon: Icons.check,
              onSelected: _saveForm,
            ),
          ],
        ),
      ],
    ),
  ];

  // ── Sichtbarkeit ───────────────────────────────────────
  static bool _loggedOut(NavContext ctx) => !ctx.isLoggedIn;

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

  // ── Ableitung aus der URL ──────────────────────────────

  /// Tiefste Kette, deren letzter Knoten auf [location] passt.
  /// Eltern müssen selbst nicht matchen — so dürfen Unterpunkte
  /// eigene, frei gewählte Pfade haben.
  static List<NavDestination> chainForLocation(String location) {
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
    return result.isEmpty ? [destinations.first] : result;
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
