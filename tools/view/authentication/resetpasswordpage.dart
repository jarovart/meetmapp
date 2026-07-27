import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:casttime/app/config/route_config.dart';
import 'package:casttime/app/model/exception/app_exception.dart';
import 'package:casttime/app/service/authentication_service.dart';
import 'package:casttime/app/view/util/app_errormessage_mapper.dart';
import 'package:casttime/extensions/l10n_extension.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;
  const ResetPasswordPage({super.key, required this.token});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _loading = false;
  String? _error;
  bool _done = false;

  @override
  void dispose() {
    _p1.dispose();
    _p2.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final p1 = _p1.text;
      final p2 = _p2.text;

      if (p1.length < 8) {
        throw Atleast8CharPasswordException();
      }
      if (p1 != p2) {
        throw NotMatchPasswordsException();
      }

      await AuthService.resetPassword(token: widget.token, newPassword: p1);
      if (!mounted) return;
      setState(() => _done = true);
    } catch (e, st) {
      if (!mounted) return;
      debugPrint('Error while resetting password: $e');
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
      appBar: AppBar(title: Text(context.l10n.setNewPassword)),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _done
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 64,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 12),
                        Text(context.l10n.changedPassword),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.go(RouteConfig.loginUrl);
                          },
                          child: Text(context.l10n.loginNow),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _p1,
                          decoration: InputDecoration(
                            labelText: context.l10n.newPassword,
                          ),
                          obscureText: true,
                          autofillHints: const [AutofillHints.newPassword],
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _p2,
                          decoration: InputDecoration(
                            labelText: context.l10n.repeatPassword,
                          ),
                          obscureText: true,
                          autofillHints: const [AutofillHints.newPassword],
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
                            onPressed: _loading ? null : _submit,
                            child: _loading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(context.l10n.savePassword),
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
}
