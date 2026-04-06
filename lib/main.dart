import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/controller/editmyprofile_controller.dart';
import 'package:meetmaap/app/controller/locationlist_controller.dart';
import 'package:meetmaap/app/controller/map_controller.dart';
import 'package:meetmaap/app/controller/profile_controller.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:meetmaap/app/controller/userlist_controller.dart';
import 'package:meetmaap/app/model/response/locationbase_response.dart';
import 'package:meetmaap/app/model/response/locationfull_response.dart';
import 'package:meetmaap/app/view/home_page.dart';
import 'package:meetmaap/app/view/authentication/forgotpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/loginpage.dart';
import 'package:meetmaap/app/view/authentication/registercheckemailpage.dart';
import 'package:meetmaap/app/view/authentication/registerpage.dart';
import 'package:meetmaap/app/view/authentication/resetpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/verifyemailpage.dart';
import 'package:meetmaap/app/view/map_page.dart';
import 'package:meetmaap/app/view/setting/setting_page.dart';
import 'package:meetmaap/app/view/user/edit_myprofile_page.dart';
import 'package:meetmaap/app/view/user/userlist_page.dart';
import 'package:meetmaap/testexample/testshowmodal.dart';
import 'package:meetmaap/testexample/testslidergps.dart';
import 'package:meetmaap/app/view/location/locationdetail_page.dart';
import 'package:meetmaap/app/view/location/locationlist_page.dart';
import 'package:meetmaap/app/view/location/locationcreate_page.dart';
import 'package:meetmaap/app/view/user/profile_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapViewController(mapController: MapController()),
        ),
        ChangeNotifierProvider(create: (_) => LocationListController()),
        ChangeNotifierProvider(create: (_) => UserListController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
      ],
      child: const MainApplication(),
    ),
  );
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation:
          Uri.base.path + (Uri.base.hasQuery ? '?${Uri.base.query}' : ''),
      routes: [
        /// Home (Startseite)
        GoRoute(path: '/', builder: (context, state) => const HomePage()),

        /// Location Listen-Seite
        GoRoute(
          path: '/locationlist',
          builder: (context, state) => const LocationsListPage(),
        ),

        /// Location-Seite
        GoRoute(
          path: '/locationdetail',
          builder: (context, state) {
            final locationbase =
                state.extra as LocationBaseResponse; // oder LocationBase
            return LocationDetailPage(locationbase: locationbase);
          },
        ),

        GoRoute(
          path: '/map',
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

        /// Location-Seite mit Parameter
        GoRoute(
          path: '/locationcreate',
          builder: (context, state) {
            final data = state.extra! as Map<String, dynamic>;
            return LocationCreatePage(
              point: LatLng(data['lat'], data['lng']),
              geoAddress: data['geoAddress'],
            );
          },
        ),
        GoRoute(
          path: '/profilepage',
          builder: (context, state) {
            final userId = state.extra as int?;
            return ChangeNotifierProvider(
              create: (_) => UserProfileController()..load(userId: userId),
              child: UserProfilePage(userId: userId),
            );
          },
        ),

        GoRoute(
          path: '/editmyprofilepage',
          builder: (context, state) {
            final userId = state.extra as int?;
            return ChangeNotifierProvider(
              create: (_) => EditMyProfileController()..load(userId: userId),
              child: EditMyProfilePage(),
            );
          },
        ),

        GoRoute(
          path: '/loginpage',
          builder: (context, state) {
            final returnOnSuccess = state.extra as bool? ?? true;
            return LoginPage(returnOnSuccess: returnOnSuccess);
          },
        ),
        GoRoute(
          path: '/registerpage',
          builder: (context, state) {
            return RegisterPage();
          },
        ),
        GoRoute(
          path: '/registercheckemail',
          builder: (context, state) {
            final email = state.extra as String;
            return RegisterCheckEmailPage(email: email);
          },
        ),
        GoRoute(
          path: '/verifyemail',
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
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/reset-password',
          builder: (context, state) {
            final token = state.uri.queryParameters['token'];
            if (token == null || token.isEmpty) {
              return const Scaffold(
                body: Center(child: Text('Ungültiger Link')),
              );
            }
            return ResetPasswordPage(token: token);
          },
        ),
        GoRoute(
          path: '/settingspage',
          builder: (context, state) => const SettingsPage(),
        ),

        /// User Listen-Seite
        GoRoute(
          path: '/userlist',
          builder: (context, state) => const UserListPage(),
        ),

        /*GoRoute( TODO: check if needed. new userprofilepage
          path: '/userdetail',
          builder: (context, state) {
            final userBase = state.extra as UserBaseResponse;
            return UserDetailPage(userBase: userBase);
          },
        ),*/

        /// Test ShowModal-Seite
        GoRoute(
          path: '/test-showmodal',
          builder: (context, state) {
            return TestShowModal();
          },
        ),

        /// Test Slider/GPS-Seite
        GoRoute(
          path: '/test-slidergps',
          builder: (context, state) {
            return TestSliderGps();
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Meetmaap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      routerConfig: router,
    );
  }
}
