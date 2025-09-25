import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nutzerprofil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
            ),
            SizedBox(height: 16),
            Text("Name: Max Mustermann", style: TextStyle(fontSize: 18)),
            Text("E-Mail: max@example.com", style: TextStyle(fontSize: 18)),
            Text("Telefon: +49 123 456789", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
