import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/home_page.dart';
import 'package:meetmaap/common/constants/testshowmodal.dart';
import 'package:meetmaap/common/constants/testslidergps.dart';
import 'package:meetmaap/features/locations/data/location_full.dart';
import 'package:meetmaap/features/locations/presentation/location_page.dart';
import 'package:meetmaap/features/locations/presentation/locationlist_page.dart';
import 'package:meetmaap/features/locations/presentation/locationcreate_page.dart';

void main() {
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
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

        /// Location-Seite mit Parameter
        GoRoute(
          path: '/location/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;

            // TODO: echte Daten laden
            final mockLocation = LocationFull(
              id: id,
              title: "Chill Spot $id",
              address: "Adresse $id in Bremen",
              description:
                  "Eine sehr coole Location zum Chillen, Essen und Treffen.",
              position: LatLng(53.0, 8.8),
              date: "Heute um 18:00",
              thumbnailUrl:
                  "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800",
              imageUrl:
                  "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800",
              user: "Max Mustermann",
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
