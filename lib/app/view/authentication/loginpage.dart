import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/repositories/AuthRepository.dart';
import 'package:meetmaap/app/view/authentication/forgotpasswordpage.dart';

class LoginPage extends StatefulWidget {
  final bool returnOnSuccess;
  const LoginPage({super.key, this.returnOnSuccess = true});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool? _loggedIn;
  String? _username;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAuthState();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await AuthRepository.login(
        username: _userCtrl.text.trim(),
        password: _passCtrl.text,
      );
      final name = await AuthRepository.getUsername();
      debugPrint('Logged in as $name');
      if (!mounted) return;
      setState(() {
        _loggedIn = true;
        _username = name;
      });
      TextInput.finishAutofillContext();
      if (widget.returnOnSuccess) context.pop(true);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submitLogout() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await AuthRepository.logout();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _loggedIn = false;
          _username = null;
        });
      }
    }
  }

  Future<void> _loadAuthState() async {
    final loggedIn = await AuthRepository.isLoggedIn();
    final username = loggedIn ? await AuthRepository.getUsername() : null;
    if (!mounted) return;
    setState(() {
      _loggedIn = loggedIn;
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loggedIn == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _loggedIn! ? logoutWidgets() : loginWidgets(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> logoutWidgets() {
    return [
      Text('Logout', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16),
      Text('Eingeloggt als $_username'),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _loading ? null : _submitLogout,
          child: _loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Ausloggen'),
        ),
      ),
    ];
  }

  List<Widget> loginWidgets() {
    return [
      Text('Login', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16),

      AutofillGroup(
        child: Column(
          children: [
            TextField(
              controller: _userCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _passCtrl,
              decoration: const InputDecoration(labelText: 'Passwort'),
              autofillHints: const [AutofillHints.password],
              obscureText: true,
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),

      TextButton(
        onPressed: () => context.push('/forgot-password'),
        child: const Text('Passwort vergessen?'),
      ),

      const SizedBox(height: 16),
      if (_error != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(_error!, style: const TextStyle(color: Colors.red)),
        ),

      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _loading ? null : _submit,
          child: _loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Einloggen'),
        ),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Noch keinen Account?"),
          TextButton(
            onPressed: () {
              context.push('/registerpage');
            },
            child: const Text('Registrieren'),
          ),
        ],
      ),
    ];
  }
}
