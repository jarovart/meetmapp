import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/config/appscrollbehavior.dart';
import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/navigation/app_router.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/theme/appdesign.dart';
import 'package:casttime/app/theme/themedesign.dart';
import 'package:casttime/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:casttime/features/auth/presentation/bloc/auth_event.dart';
import 'package:casttime/features/map/presentation/bloc/map_bloc.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();
  await setupDependencies();

  runApp(CasttimeApp());
  /*runApp(
    MaterialApp(
      home: const MapPage(),
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      //routerConfig: router,
      scrollBehavior: const AppScrollBehavior(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: null, // null system language
    ),
  );*/
}

class CasttimeApp extends StatelessWidget {
  const CasttimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final design = AppDesign.system;
    return MultiBlocProvider(
      providers: [
        //ChangeNotifierProvider(create: (_) => LocationListController()),
        //ChangeNotifierProvider(create: (_) => AuthController("initmain")),
        /*ChangeNotifierProvider(
          create: (_) => MapViewController(mapController: MapController()),
        ),*/
        BlocProvider<AuthBloc>.value(
          value: getIt<AuthBloc>()..add(AuthStatusRequested()),
        ),
        BlocProvider<AppBannerCubit>.value(value: getIt<AppBannerCubit>()),
        BlocProvider<MapBloc>.value(value: getIt<MapBloc>()),
      ],
      child: MaterialApp.router(
        //home: const MapPage(),
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        scrollBehavior: const AppScrollBehavior(),

        theme: ThemeDesign.mapLightTheme(design),
        darkTheme: ThemeDesign.mapDarkTheme(design),
        themeMode: ThemeDesign.getThemeModeByAppDesign(design),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: null, // null system language
      ),
    );
  }
}

/*
void mains2() async {
  final authController = AuthController("main!");
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
            child: MapPage(), //locationToCheck: loc),
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
  }*/
