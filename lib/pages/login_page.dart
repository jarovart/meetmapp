import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _message;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleAuthAction(
      Future<AuthResult> Function(String, String) action,
      ) async {
    setState(() {
      _isLoading = true;
      _message = null;
    });

    final result = await action(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;

      switch (result) {
        case AuthSuccess(:final response):
          _message = "✅ Willkommen ${response.user?.email ?? ''}";
        case AuthFailure(:final message):
          _message = "❌ Fehler: $message";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supabase Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextFields(),
            const SizedBox(height: 16),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading) ...[
              ElevatedButton(
                onPressed: () => _handleAuthAction(authService.signIn),
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () => _handleAuthAction(authService.signUp),
                child: const Text("Registrieren"),
              ),
            ],
            const SizedBox(height: 16),
            if (_message != null) Text(_message!),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: "Email"),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: "Passwort"),
          obscureText: true,
        ),
      ],
    );
  }
}
