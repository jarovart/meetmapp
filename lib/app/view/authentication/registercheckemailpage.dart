import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/exceptions/cooldownexception.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class RegisterCheckEmailPage extends StatefulWidget {
  final String email;
  const RegisterCheckEmailPage({super.key, required this.email});

  @override
  State<RegisterCheckEmailPage> createState() => _RegisterCheckEmailPageState();
}

class _RegisterCheckEmailPageState extends State<RegisterCheckEmailPage> {
  bool _loading = false;
  String? _error;
  int _cooldown = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.mark_email_read, size: 64),
              Text(
                'Registrierung erfolgreich!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(
                onPressed: (_loading || _cooldown > 0)
                    ? null
                    : () => _resendVerificationEmail(),
                child: _loading
                    ? const CircularProgressIndicator()
                    : _cooldown > 0
                    ? Text('Bitte warten ($_cooldown s)')
                    : Text('E-Mail erneut senden'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resendVerificationEmail() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await AuthRepository.resendVerificationEmail(email: widget.email);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-Mail wurde erneut gesendet')),
      );
    } catch (e) {
      if (e is CooldownException) {
        startCooldown(e.seconds);
        setState(() => _error = e.message);
      } else {
        setState(() => _error = e.toString());
      }
    } finally {
      setState(() => _loading = false);
    }
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
