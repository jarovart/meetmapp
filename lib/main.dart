import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/config/appscrollbehavior.dart';
import 'package:casttime/app/config/dev_config.dart';
import 'package:casttime/app/config/route_config.dart';
import 'package:casttime/app/controller/auth_controller.dart';
import 'package:casttime/app/controller/edit_mylocation_controller.dart';
import 'package:casttime/app/controller/editmyprofile_controller.dart';
import 'package:casttime/app/controller/home_controller.dart';
import 'package:casttime/app/controller/info_controller.dart';
import 'package:casttime/app/controller/locationcreate_controller.dart';
import 'package:casttime/app/controller/locationdetails_controller.dart';
import 'package:casttime/app/controller/locationlist_controller.dart';
import 'package:casttime/app/controller/login_controller.dart';
import 'package:casttime/app/controller/map_controller.dart';
import 'package:casttime/app/controller/profile_controller.dart';
import 'package:casttime/app/controller/setting_controller.dart';
import 'package:casttime/app/controller/userlist_controller.dart';
import 'package:casttime/app/model/enums/appdesign.dart';
import 'package:casttime/app/model/response/locationbase_response.dart';
import 'package:casttime/app/model/response/locationfull_response.dart';
import 'package:casttime/app/model/response/userbase_response.dart';
import 'package:casttime/app/view/design/themedesign.dart';
import 'package:casttime/app/view/home_page.dart';
import 'package:casttime/app/view/authentication/forgotpasswordpage.dart';
import 'package:casttime/app/view/authentication/loginpage.dart';
import 'package:casttime/app/view/authentication/registercheckemailpage.dart';
import 'package:casttime/app/view/authentication/registerpage.dart';
import 'package:casttime/app/view/authentication/resetpasswordpage.dart';
import 'package:casttime/app/view/authentication/verifyemailpage.dart';
import 'package:casttime/app/view/location/edit_mylocation_page.dart';
import 'package:casttime/app/view/location/locationdetail_page.dart';
import 'package:casttime/app/view/map_page.dart';
import 'package:casttime/app/view/model/appliedsettings_model.dart';
import 'package:casttime/app/view/setting/info_page.dart';
import 'package:casttime/app/view/setting/setting_page.dart';
import 'package:casttime/app/view/setting/support_page.dart';
import 'package:casttime/app/view/user/edit_myprofile_page.dart';
import 'package:casttime/app/view/user/userlist_page.dart';
import 'package:casttime/extensions/l10n_extension.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:casttime/testexample/testshowmodal.dart';
import 'package:casttime/testexample/testslidergps.dart';
import 'package:casttime/app/view/location/locationlist_page.dart';
import 'package:casttime/app/view/location/locationcreate_page.dart';
import 'package:casttime/app/view/user/profile_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final authController = AuthController("main");
  await authController.loadLoginLocal();
  final settingsController = SettingsController();
  await settingsController.loadSettingsLocal();
  if (!DevConfig.isDev) {
    debugPrint("DevConfig is not active, production Api will be used");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authController),

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
        ChangeNotifierProvider.value(value: settingsController),
      ],
      child: Selector<SettingsController, AppliedAppSettings?>(
        selector: (_, controller) => controller.appliedSetting,
        builder: (context, appliedSetting, _) {
          return MainApplication(setting: appliedSetting);
        },
      ),
    ),
  );
}

class MainApplication extends StatelessWidget {
  final AppliedAppSettings? setting;
  MainApplication({super.key, required this.setting});

  final GoRouter router = GoRouter(
    routes: [
      // ─────────────────────────────────────────────
      // HomePage Section
      // ────────────────────────────────────────────a─
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
            return Scaffold(
              body: Center(child: Text(context.l10n.invalidVerifyLink)),
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
            return Scaffold(
              body: Center(child: Text(context.l10n.invalidVerifyLink)),
            );
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
      GoRoute(
        path: RouteConfig.supportUrl,
        builder: (context, state) => const SupportPage(),
      ),
      GoRoute(
        path: RouteConfig.infoUrl,
        builder: (context, state) {
          final isLoggedIn = context.read<AuthController>().isLoggedIn;
          return ChangeNotifierProvider(
            create: (_) => InfoController()..load(isLoggedIn),
            child: const InfoPage(),
          );
        },
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
    final design = setting?.design ?? AppDesign.system;

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeDesign.mapLightTheme(design),
      darkTheme: ThemeDesign.mapDarkTheme(design),
      themeMode: ThemeDesign.getThemeModeByAppDesign(design),
      routerConfig: router,
      scrollBehavior: const AppScrollBehavior(),

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      locale: setting?.locale, // null = Systemsprache verwenden
    );
  }
}
