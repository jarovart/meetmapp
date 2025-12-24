import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/repositories/AuthRepository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Beispiel-Daten (später von AuthService oder Datenbank laden)
  final String _name = "Max Mustermann";
  final String _email = "max@example.com";
  final String _phone = "+49 123 456789";
  final String _avatarUrl = "https://i.pravatar.cc/150?img=3";
  bool _checkingAuth = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final loggedIn = await AuthRepository.isLoggedIn();

    if (!mounted) return;

    if (!loggedIn) {
      final ok = await context.push<bool>('/authoverviewpage');

      if (ok != true) {
        // User hat Login abgebrochen → Seite schließen
        if (mounted) context.pop();
        return;
      }
    }

    // User ist jetzt sicher eingeloggt
    setState(() => _checkingAuth = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingAuth) {
      return Scaffold(
        appBar: AppBar(title: const Text("Nutzerprofil")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Nutzerprofil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            const SizedBox(height: 16),
            ProfileInfoRow(label: "Name", value: _name),
            ProfileInfoRow(label: "E-Mail", value: _email),
            ProfileInfoRow(label: "Telefon", value: _phone),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(radius: 40, backgroundImage: NetworkImage(_avatarUrl));
  }
}

/// Wiederverwendbares Info-Widget für Profilzeilen
class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text("$label: $value", style: const TextStyle(fontSize: 18)),
    );
  }
}
