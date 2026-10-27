import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/navigation/app_navigation.dart';
import 'package:casttime/app/navigation/main_navigation_shell.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/core/util/go_router_refresh_stream.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/cubit/pages/login_page.dart';
import 'package:casttime/features/info/presentation/pages/info_page.dart';
import 'package:casttime/features/location/presentation/pages/location_list_page.dart';
import 'package:casttime/features/map/presentation/pages/map_page.dart';
import 'package:casttime/features/profile/presentation/pages/profile_page.dart';
import 'package:casttime/features/setting/presentation/page/settings_page.dart';
import 'package:casttime/features/support/presentation/support_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _mapNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'map');

final _forYouNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'forYou');

final _createNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'create');

final _myLocationsNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'myLocations',
);

final _profileNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteConfig.mapUrl,
  refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  redirect: _authGuard,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainNavigationShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _mapNavigatorKey,
          routes: [
            GoRoute(
              path: RouteConfig.mapUrl,
              builder: (_, __) => const MapPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _forYouNavigatorKey,
          routes: [
            GoRoute(
              path: RouteConfig.locationListUrl,
              builder: (_, __) => const LocationsListPage(),
            ),
            GoRoute(
              path: RouteConfig.profileUrl,
              builder: (_, state) =>
                  ProfilePage(username: state.pathParameters['username']!),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _createNavigatorKey,
          routes: [
            GoRoute(
              path: '/create-location',
              builder: (_, __) => const SizedBox(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _myLocationsNavigatorKey,
          routes: [
            GoRoute(
              path: '/my-locations',
              builder: (_, __) => const SizedBox(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: RouteConfig.myProfileUrl,
              builder: (_, __) => const ProfilePage(),
              routes: [
                GoRoute(path: 'edit', builder: (_, __) => const SizedBox()),
              ],
            ),
            GoRoute(
              path: RouteConfig.loginUrl,
              builder: (_, state) => LoginPage(
                redirectionUrl: RouteConfig.getRedirectUrlFromLogin(state.uri),
              ),
            ),
            GoRoute(
              path: RouteConfig.infoUrl,
              builder: (_, __) => const InfoPage(),
            ),
            GoRoute(
              path: RouteConfig.supportUrl,
              builder: (_, __) => const SupportPage(),
            ),
            GoRoute(
              path: RouteConfig.friendsUrl,
              builder: (_, __) => const SizedBox(),
            ),
            GoRoute(
              path: RouteConfig.settingsUrl,
              builder: (_, __) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

String? _authGuard(BuildContext context, GoRouterState state) {
  final isLoggedIn = getIt<AuthCubit>().state.isLoggedIn;
  final path = state.uri.path;

  if (!isLoggedIn && AppNavigation.isProtected(path)) {
    return RouteConfig.getLoginUrlWithRedirect(state.uri.toString());
  }
  if (isLoggedIn && path == RouteConfig.loginUrl) {
    return RouteConfig.getRedirectUrlFromLogin(state.uri) ??
        RouteConfig.myProfileUrl;
  }
  return null;
}
