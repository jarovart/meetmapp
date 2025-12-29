import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/model/exceptions/cooldownexception.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userCtrl = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _passCtrl2 = TextEditingController();
  bool _loading = false;
  String? _error;
  String? registeredUsername;
  int _cooldown = 0;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final username = _userCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text;
    final password2 = _passCtrl2.text;
    final firstname = _firstname.text;
    final lastname = _lastname.text;

    try {
      if (username.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          password2.isEmpty ||
          firstname.isEmpty ||
          lastname.isEmpty) {
        throw Exception('Alle Felder müssen ausgefüllt sein');
      }

      if (password != password2) {
        throw Exception('Passwörter stimmen nicht überein');
      }

      if (password.length < 8) {
        throw Exception('Passwörter müssen mindestens 8 Zeichen lang sein');
      }

      if (email.contains(' ') || !email.contains('@')) {
        throw Exception('Ungültige E-Mail Adresse');
      }

      await AuthRepository.register(
        username: username,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      );
      if (mounted) context.push('/registercheckemail', extra: email);

      /*if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registrierung erfolgreich')),
      );
      setState(() => registeredUsername = username);*/
    } catch (e) {
      if (e is CooldownException) {
        startCooldown(e.seconds);
        setState(() => _error = e.message);
      } else {
        setState(() => _error = e.toString());
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstname,
                        autofillHints: const [AutofillHints.givenName],
                        decoration: const InputDecoration(
                          labelText: 'Firstname',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _lastname,
                        autofillHints: const [AutofillHints.familyName],
                        decoration: const InputDecoration(
                          labelText: 'Familyname',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _emailCtrl,
                  autofillHints: const [AutofillHints.email],
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
                  onPressed: (_loading || _cooldown > 0) ? null : _submit,
                  child: _loading
                      ? const CircularProgressIndicator()
                      : _cooldown > 0
                      ? Text('Bitte warten ($_cooldown s)')
                      : const Text('Registrieren'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startCooldown(int seconds) {
    setState(() => _cooldown = seconds);

    Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_cooldown <= 1) {
        t.cancel();
        setState(() => _cooldown = 0);
      } else {
        setState(() => _cooldown--);
      }
    });
  }
}
