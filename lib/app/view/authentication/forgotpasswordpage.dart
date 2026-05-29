import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meetmaap/app/model/exception/app_exception.dart';
import 'package:meetmaap/app/repository/authentication_repository.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _sent = false;
  int _cooldown = 0;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final email = _emailCtrl.text.trim();
      if (email.isEmpty || !email.contains('@') || email.contains(' ')) {
        throw ValidEmailHintException();
      }

      await AuthRepository.forgotPassword(email: email);
      if (!mounted) return;
      setState(() => _sent = true);
    } catch (e, st) {
      debugPrint('Error while reset forgotten password: $e');
      if (!mounted) return;
      if (e is CooldownException) {
        startCooldown(e.seconds);
      }
      debugPrint('Error while register user: $e');
      debugPrintStack(stackTrace: st);
      setState(
        () => _error = AppErrorMapper.toUserMessage(
          e,
          context.l10n,
          fallback: context.l10n.errorPasswordReset,
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.forgotPassword)),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _sent
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.mark_email_read, size: 64),
                        const SizedBox(height: 12),
                        Text(
                          context.l10n.linkSendToEmail,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(
                            labelText: 'E-Mail',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _submit(),
                        ),
                        const SizedBox(height: 12),
                        if (_error != null)
                          Text(
                            _error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (_loading || _cooldown > 0)
                                ? null
                                : _submit,
                            child: _loading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : _cooldown > 0
                                ? Text(context.l10n.waitForXSeconds(_cooldown))
                                : Text(context.l10n.sendLink),
                          ),
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
        setState(() => _cooldown = 0);
      } else {
        setState(() => _cooldown--);
      }
    });
  }
}
