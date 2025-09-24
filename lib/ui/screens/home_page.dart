import 'package:flutter/material.dart';
import '../widgets/auth_service.dart';

class HomePage extends StatelessWidget {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = authService.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text("Supabase Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text("👋 Willkommen ${user?.email ?? 'Unbekannt'}"),
      ),
    );
  }
}
