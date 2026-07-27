import 'package:casttime/app/navigation/main_navigation_shell.dart';
import 'package:casttime/features/map/presentation/pages/map_page.dart';
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
  routes: [
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
              path: '/locationlist',
              builder: (context, state) {
                return SizedBox(); //const LocationsListPage();
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
              path: '/profile',
              builder: (context, state) {
                return SizedBox(); // const UserProfilePage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
