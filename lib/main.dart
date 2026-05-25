import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/app_config.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/edit_mylocation_controller.dart';
import 'package:meetmaap/app/controller/editmyprofile_controller.dart';
import 'package:meetmaap/app/controller/home_controller.dart';
import 'package:meetmaap/app/controller/locationcreate_controller.dart';
import 'package:meetmaap/app/controller/locationdetails_controller.dart';
import 'package:meetmaap/app/controller/locationlist_controller.dart';
import 'package:meetmaap/app/controller/login_controller.dart';
import 'package:meetmaap/app/controller/map_controller.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:meetmaap/app/controller/userlist_controller.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/model/response/userbase_response.dart';
import 'package:meetmaap/app/view/home_page.dart';
import 'package:meetmaap/app/view/authentication/forgotpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/loginpage.dart';
import 'package:meetmaap/app/view/authentication/registercheckemailpage.dart';
import 'package:meetmaap/app/view/authentication/registerpage.dart';
import 'package:meetmaap/app/view/authentication/resetpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/verifyemailpage.dart';
import 'package:meetmaap/app/view/location/edit_mylocation_page.dart';
import 'package:meetmaap/app/view/location/locationdetail_page.dart';
import 'package:meetmaap/app/view/map_page.dart';
import 'package:meetmaap/app/view/setting/setting_page.dart';
import 'package:meetmaap/app/view/user/edit_myprofile_page.dart';
import 'package:meetmaap/app/view/user/userlist_page.dart';
import 'package:meetmaap/testexample/testshowmodal.dart';
import 'package:meetmaap/testexample/testslidergps.dart';
import 'package:meetmaap/app/view/location/locationlist_page.dart';
import 'package:meetmaap/app/view/location/locationcreate_page.dart';
import 'package:meetmaap/app/view/user/profile_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

void main() {
  usePathUrlStrategy();
  runApp(
    //create: (context) =>
    //          HomeController(authController: context.read<AuthController>()),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthController("(Authcontrollermain)"),
        ),

        ChangeNotifierProxyProvider<AuthController, HomeController>(
          create: (context) =>
              HomeController()
                ..updateMyProfile(context.read<AuthController>().myProfile),
          update: (_, authController, homeController) {
            homeController ??= HomeController();
            homeController.updateMyProfile(authController.myProfile);
            return homeController;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => MapViewController(mapController: MapController()),
        ),
        ChangeNotifierProvider(create: (_) => LocationListController()),
        ChangeNotifierProvider(create: (_) => UserListController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
      ],
      child: MainApplication(),
    ),
  );
}

class MainApplication extends StatelessWidget {
  MainApplication({super.key});

  final GoRouter router = GoRouter(
    routes: [
      // ─────────────────────────────────────────────
      // HomePage Section
      // ─────────────────────────────────────────────
      GoRoute(
        path: RouteConfig.homePageUrl,
        builder: (context, state) => Consumer2<HomeController, AuthController>(
          builder: (context, homeController, authController, _) {
            return HomePage(
              homeController: homeController,
              authController: authController,
            );
          },
        ),
      ),

      GoRoute(
        path: RouteConfig.mapUrl,
        builder: (context, state) {
          final loc = state.extra as LocationFullResponse;
          return ChangeNotifierProvider<MapViewController>(
            create: (_) {
              final c = MapViewController(mapController: MapController());
              c.selectLocation(loc);
              return c;
            },
            child: MapPage(locationToCheck: loc),
          );
        },
      ),

      // ─────────────────────────────────────────────
      // Location Section
      // ─────────────────────────────────────────────
      GoRoute(
        path: RouteConfig.locationListUrl,
        builder: (context, state) => const LocationsListPage(),
      ),

      GoRoute(
        path: RouteConfig.locationUrl,
        builder: (context, state) {
          final locationId = state.pathParameters['locationId'];
          final location = state.extra as LocationBaseResponse?;
          final authController = context.read<AuthController>();

          return ChangeNotifierProvider(
            create: (_) =>
                LocationDetailsController(authController: authController)
                  ..load(locationId, location),
            child: const LocationDetailPage(),
          );
        },
        routes: [
          GoRoute(
            path: RouteConfig.editUrl,
            builder: (context, state) {
              final locationId = state.pathParameters['locationId'];
              final location = state.extra as LocationFullResponse?;
              final authController = context.read<AuthController>();

              return ChangeNotifierProvider(
                create: (_) =>
                    EditMyLocationController(authController: authController)
                      ..load(locationId, location),
                child: EditMyLocationPage(),
              );
            },
          ),
        ],
      ),

      GoRoute(
        path: RouteConfig.locationCreateUrl,
        redirect: (context, state) async {
          final authController = context.read<AuthController>();
          await authController.refreshLogin("(locationcreate main)");

          if (!authController.isLoggedIn) {
            debugPrint('Received locationCreate: ${state.uri.toString()}');
            return RouteConfig.getLoginUrlWithRedirect(state.uri.toString());
          }
          return null;
        },
        builder: (context, state) {
          final lat = double.tryParse(state.uri.queryParameters['lat'] ?? '0');
          final lng = double.tryParse(state.uri.queryParameters['lng'] ?? '0');
          final geoAddressRaw = state.uri.queryParameters['geoaddress'] ?? '';

          return ChangeNotifierProvider<LocationCreateController>(
            create: (_) {
              final c = LocationCreateController(
                point: LatLng(lat!, lng!),
                geoAddress: geoAddressRaw,
              );
              return c;
            },
            child: Consumer2<LocationCreateController, AuthController>(
              builder: (context, locationCreateController, authController, _) {
                return LocationCreatePage(
                  locationCreateController: locationCreateController
                    ..myProfile = authController.myProfile,
                  authController: authController,
                );
              },
            ),
          );
        },
      ),

      // ─────────────────────────────────────────────
      // User Section
      // ─────────────────────────────────────────────
      GoRoute(
        path: RouteConfig.userListUrl,
        builder: (context, state) => const UserListPage(),
      ),

      GoRoute(
        path: RouteConfig.profileUrl,
        builder: (context, state) {
          final username = state.pathParameters['username'];
          final userBaseResponse = state.extra as UserBaseResponse?;

          return ChangeNotifierProvider(
            create: (_) =>
                UserProfileController(username)..load(userBaseResponse),
            child: const UserProfilePage(),
          );
        },
        routes: [
          GoRoute(
            path: RouteConfig.editUrl,
            builder: (context, state) {
              final username = state.pathParameters['username'];
              return ChangeNotifierProvider(
                create: (_) => EditMyProfileController(username)..load(),
                child: EditMyProfilePage(),
              );
            },
          ),
        ],
      ),

      // ─────────────────────────────────────────────
      // Authentication Section
      // ─────────────────────────────────────────────
      GoRoute(
        path: RouteConfig.loginUrl,
        builder: (context, state) {
          final redirectionUrl = state.uri.queryParameters['redirect'];

          return ChangeNotifierProxyProvider<AuthController, LoginController>(
            create: (_) => LoginController(),
            update: (_, authController, loginController) {
              loginController ??= LoginController();
              loginController.updateMyProfile(authController.myProfile);
              return loginController;
            },
            child: Consumer2<LoginController, AuthController>(
              builder: (context, loginController, authController, _) {
                return LoginPage(
                  redirectionUrl: redirectionUrl,
                  loginController: loginController,
                  authController: authController,
                );
              },
            ),
          );
        },
      ),

      GoRoute(
        path: RouteConfig.registerUrl,
        builder: (context, state) {
          return RegisterPage();
        },
      ),
      GoRoute(
        path: RouteConfig.sendRegisterEmailUrl,
        builder: (context, state) {
          final email = state.extra as String;
          return RegisterCheckEmailPage(email: email);
        },
      ),
      GoRoute(
        path: RouteConfig.verifyRegisterEmailUrl,
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];

          if (token == null || token.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('Ungültiger Verifizierungslink')),
            );
          }

          return VerifyPage(token: token);
        },
      ),

      GoRoute(
        path: RouteConfig.forgotPasswordUrl,
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      GoRoute(
        path: RouteConfig.resetPasswordUrl,
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          if (token == null || token.isEmpty) {
            return const Scaffold(body: Center(child: Text('Ungültiger Link')));
          }
          return ResetPasswordPage(token: token);
        },
      ),

      // ─────────────────────────────────────────────
      // Settings Section
      // ─────────────────────────────────────────────
      GoRoute(
        path: RouteConfig.settingsUrl,
        builder: (context, state) => const SettingsPage(),
      ),

      // ─────────────────────────────────────────────
      // Testing Section
      // ─────────────────────────────────────────────
      GoRoute(
        path: RouteConfig.testShowModalUrl,
        builder: (context, state) {
          return TestShowModal();
        },
      ),

      GoRoute(
        path: RouteConfig.testSliderGps,
        builder: (context, state) {
          return TestSliderGps();
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      routerConfig: router,
    );
  }
}
