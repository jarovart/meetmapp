import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/navigation/main_navigation_shell.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/core/util/go_router_refresh_stream.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/auth/presentation/cubit/pages/login_page.dart';
import 'package:casttime/features/location/presentation/pages/location_list_page.dart';
import 'package:casttime/features/map/presentation/pages/map_page.dart';
import 'package:casttime/features/profile/presentation/pages/profile_page.dart';
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
  initialLocation: '/map',
  refreshListenable: GoRouterRefreshStream(getIt<AuthCubit>().stream),
  routes: [
    /*GoRoute(
      path: RouteConfig.loginUrl,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final redirect = state.uri.queryParameters['redirect'];
        return LoginPage(redirectionUrl: redirect);
      },
    ),*/

    // WICHTIG: literale Route VOR der parametrisierten deklarieren,
    // sonst würde "/profile/me" fälschlich als username="me" gematcht.
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _mapNavigatorKey,
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) {
                return const MapPage();
              },
              routes: [
                GoRoute(
                  path: 'locationlist',
                  builder: (context, state) {
                    return SizedBox(); //LocationsListPage();
                  },
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _forYouNavigatorKey,
          routes: [
            GoRoute(
              path: RouteConfig.locationListUrl,
              builder: (context, state) {
                return const LocationsListPage();
              },
            ),

            GoRoute(
              path: RouteConfig.profileUrl,
              //parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                final username = state.pathParameters['username']!;
                return ProfilePage(username: username);
              },
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _createNavigatorKey,
          routes: [
            GoRoute(
              path: '/create-location',
              builder: (context, state) {
                return SizedBox();
                //const UserProfilePage(); // LocationCreatePage();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _myLocationsNavigatorKey,
          routes: [
            GoRoute(
              path: '/my-locations',
              builder: (context, state) {
                return SizedBox(); //const UserProfilePage();
              },
            ),
          ],
        ),

        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: RouteConfig.myProfileUrl,
              //parentNavigatorKey: _rootNavigatorKey,
              redirect: (context, state) {
                final isLoggedIn = getIt<AuthCubit>().state.isLoggedIn;
                if (!isLoggedIn) {
                  return '${RouteConfig.loginUrl}?redirect=${Uri.encodeComponent(RouteConfig.myProfileUrl)}';
                }
                return null;
              },
              builder: (context, state) {
                return ProfilePage();
              },
            ),
            GoRoute(
              path: RouteConfig.loginUrl,
              builder: (context, state) {
                final redirect = state.uri.queryParameters['redirect'];
                return LoginPage(redirectionUrl: redirect);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
