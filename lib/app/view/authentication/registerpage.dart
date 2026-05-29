import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/service/authentication_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';

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
        throw FillAllFieldsException();
      }

      if (password != password2) {
        throw NotMatchPasswordsException();
      }

      if (password.length < 8) {
        throw Atleast8CharPasswordException();
      }

      if (email.contains(' ') || !email.contains('@')) {
        throw EmailInvalidException();
      }

      await AuthService.register(
        username: username,
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      );
      if (mounted) context.push(RouteConfig.sendRegisterEmailUrl, extra: email);
    } catch (e, st) {
      if (e is CooldownException) {
        startCooldown(e.seconds);
      }
      debugPrint('Error while register user: $e');
      debugPrintStack(stackTrace: st);
      setState(
        () => _error = AppErrorMapper.toUserMessage(
          e,
          context.l10n,
          fallback: context.l10n.errorRegister,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.register)),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.register,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _userCtrl,
                    autofillHints: const [AutofillHints.newUsername],
                    decoration: InputDecoration(
                      labelText: context.l10n.username,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstname,
                          autofillHints: const [AutofillHints.givenName],
                          decoration: InputDecoration(
                            labelText: context.l10n.firstName,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _lastname,
                          autofillHints: const [AutofillHints.familyName],
                          decoration: InputDecoration(
                            labelText: context.l10n.familyName,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailCtrl,
                    autofillHints: const [AutofillHints.email],
                    decoration: InputDecoration(labelText: context.l10n.email),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passCtrl,
                    autofillHints: const [AutofillHints.newPassword],
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.password,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passCtrl2,
                    autofillHints: const [AutofillHints.newPassword],
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.repeatPassword,
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
                        ? Text(context.l10n.waitForXSeconds(_cooldown))
                        : Text(context.l10n.register),
                  ),
                ],
              ),
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
        setState(() {
          _cooldown = 0;
          _error = null;
        });
      } else {
        setState(() => _cooldown--);
      }
    });
  }
}
