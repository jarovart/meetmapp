import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/view/home_page.dart';
import 'package:meetmaap/app/view/authentication/forgotpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/loginpage.dart';
import 'package:meetmaap/app/view/authentication/registercheckemailpage.dart';
import 'package:meetmaap/app/view/authentication/registerpage.dart';
import 'package:meetmaap/app/view/authentication/resetpasswordpage.dart';
import 'package:meetmaap/app/view/authentication/verifyemailpage.dart';
import 'package:meetmaap/testexample/testshowmodal.dart';
import 'package:meetmaap/testexample/testslidergps.dart';
import 'package:meetmaap/app/model/location_full.dart';
import 'package:meetmaap/app/view/locations/locationdetail_page.dart';
import 'package:meetmaap/app/view/locations/locationlist_page.dart';
import 'package:meetmaap/app/view/locations/locationcreate_page.dart';
import 'package:meetmaap/app/view/users/profile_page.dart';

void main() {
  runApp(const MainApplication());
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

        /// Location Listen-Seite ohne Parameter
        GoRoute(
          path: '/locationlist/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return LocationsPage(locationId: id);
          },
        ),

        /// Location-Seite mit Parameter EXAMPLE
        GoRoute(
          path: '/location/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;

            final mockLocation = LocationFull(
              id: int.tryParse(id) ?? 0,
              title: "Chill Spot $id",
              //address: "Adresse $id in Bremen",
              description:
                  "Eine sehr coole Location zum Chillen, Essen und Treffen1.",
              creationDateTime: DateTime.now(),
              startDateTime: DateTime.now(),
              endDateTime: DateTime.now(),
              position: LatLng(53.0, 8.8),
              thumbnailUrl:
                  "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800",
              imageUrl:
                  "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800",
              createdUserId: 12,
              createdUsername: "jarovart",
              joinedUserCount: 14,
              likedUserCount: 13,
            );

            return LocationDetailPage(location: mockLocation);
          },
        ),

        /// Location-Seite mit Parameter
        GoRoute(
          path: '/locationcreate/:lat/:lng',
          builder: (context, state) {
            final lat = double.parse(state.pathParameters['lat']!);
            final lng = double.parse(state.pathParameters['lng']!);
            return LocationCreatePage(point: LatLng(lat, lng));
          },
        ),

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
        GoRoute(
          path: '/profilepage',
          builder: (context, state) {
            return ProfilePage();
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
          path: '/verify',
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
