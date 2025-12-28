import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      // Root widget
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.red,
          title: const Text('My Home Page'),
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  const Text('Hello, World!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      print('Click!');
                    },
                    child: const Text('A button'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

final storage = FlutterSecureStorage();

Future<void> saveTokens(String accessToken, String refreshToken) async {
  await storage.write(key: "accessToken", value: accessToken);
  await storage.write(key: "refreshToken", value: refreshToken);
}

Future<String?> getAccessToken() => storage.read(key: "accessToken");
Future<String?> getRefreshToken() => storage.read(key: "refreshToken");

Future<List<dynamic>> loadLocations() async {
  final token = await getAccessToken();
  final url = Uri.parse("http://localhost:8080/api/locations");

  final response = await http.get(
    url,
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else if (response.statusCode == 401) {
    // Token abgelaufen -> refresh
    await refreshTokenFlow();
    return loadLocations(); // nochmal versuchen
  }

  throw Exception("Fehler beim Laden");
}

Future<void> refreshTokenFlow() async {
  final refresh = await getRefreshToken();
  if (refresh == null) return;

  final url = Uri.parse("http://localhost:8080/api/auth/refresh");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"refreshToken": refresh}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await saveTokens(data["accessToken"], data["refreshToken"]);
  } else {
    // Refresh fehlgeschlagen -> User ausloggen
    logout();
  }
}

void logout() async {
  await storage.deleteAll();
  print("User logged out");
  navigatorKey.currentState!.pushReplacementNamed(
    '/login',
  ); //navigatorkey in MaterialApp
}

/*
redirect: (context, state) async {
  final access = await getAccessToken();

  if (access == null && state.matchedLocation != '/login') {
    return '/login';
  }

  return null;
}*/
