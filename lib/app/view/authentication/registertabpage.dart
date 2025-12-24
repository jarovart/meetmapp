import 'package:flutter/material.dart';
import 'package:meetmaap/app/repositories/authrepository.dart';

class RegisterTabPage extends StatefulWidget {
  const RegisterTabPage({super.key});

  @override
  State<RegisterTabPage> createState() => _RegisterTabPageState();
}

class _RegisterTabPageState extends State<RegisterTabPage> {
  final _userCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _passCtrl2 = TextEditingController();
  bool _loading = false;
  String? _error;
  String? registeredUsername;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final username = _userCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;
    final password2 = _passCtrl2.text;

    try {
      if (username.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          password2.isEmpty) {
        throw Exception('Alle Felder müssen ausgefüllt sein');
      }

      if (password != password2) {
        throw Exception('Passwörter stimmen nicht überein');
      }

      if (email.contains(' ') || !email.contains('@')) {
        throw Exception('Ungültige E-Mail Adresse');
      }

      await AuthRepository.register(
        username: username,
        password: password,
        email: email,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrierung erfolgreich')),
      );
      setState(() => registeredUsername = username);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (registeredUsername != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Registrierung erfolgreich!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Du kannst dich jetzt mit dem Benutzernamen "$registeredUsername" einloggen.',
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Registrieren',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _userCtrl,
                autofillHints: const [AutofillHints.newUsername],
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                autofillHints: const [AutofillHints.newPassword],
                obscureText: true,
                decoration: const InputDecoration(labelText: 'E-Mail'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passCtrl,
                autofillHints: const [AutofillHints.newPassword],
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Passwort'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passCtrl2,
                autofillHints: const [AutofillHints.newPassword],
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Passwort wiederholen',
                ),
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text('Registrieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
