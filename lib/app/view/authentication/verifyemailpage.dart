import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';

class VerifyPage extends StatefulWidget {
  final String token;

  const VerifyPage({super.key, required this.token});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _loading = false;
  bool _verified = false;
  String? _error;

  @override
  void initState() {
    super.initState();

    AuthRepository.verify(widget.token)
        .then((_) {
          if (!mounted) return;
          setState(() {
            _verified = true;
          });
        })
        .catchError((e) {
          if (!mounted) return;
          setState(() => _error = e.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!_verified) {
      return Scaffold(
        appBar: AppBar(title: const Text('E-Mail Verifizierung')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_loading) const CircularProgressIndicator(),
                if (_error != null)
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                if (_error != null)
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text('Zurück zur Startseite'),
                  ),
                if (!_loading && _error == null)
                  const Text('Verifiziere E-Mail Adresse...'),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 64),
              Text('Registrierung erfolgreich 🎉'),
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                  context.push('/loginpage');
                },
                child: Text('Jetzt einloggen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
