import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/features/locations/presentation/locations_page.dart';
import 'app/home_page.dart';

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

        /// Location-Seite mit Parameter
        GoRoute(
          path: '/location/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return LocationsPage(locationId: id);
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
