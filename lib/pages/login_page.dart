import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = "";

  Future<void> _login() async {
    final res = await authService.signIn(
      emailController.text,
      passwordController.text,
    );
    if (res?.user != null) {
      setState(() => message = "✅ Willkommen ${res!.user!.email}");
    } else {
      setState(() => message = "❌ Login fehlgeschlagen");
    }
  }

  Future<void> _signup() async {
    final res = await authService.signUp(
      emailController.text,
      passwordController.text,
    );
    if (res?.user != null) {
      setState(() => message = "✅ Benutzer erstellt: ${res!.user!.email}");
    } else {
      setState(() => message = "❌ Registrierung fehlgeschlagen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Supabase Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Passwort")),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _login, child: Text("Login")),
            ElevatedButton(onPressed: _signup, child: Text("Registrieren")),
            SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
}
