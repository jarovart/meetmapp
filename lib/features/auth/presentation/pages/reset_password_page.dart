import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.token});

  final String token;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  static const _minPasswordLength = 8;
  static const _dockBarInset = 96.0;

  final _passwordCtrl = TextEditingController();
  final _passwordRepeatCtrl = TextEditingController();

  bool _loading = false;
  bool _done = false;
  AppFailure? _failure;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _passwordRepeatCtrl.dispose();
    super.dispose();
  }

  AppFailure? _validate() {
    if (_passwordCtrl.text.isEmpty || _passwordRepeatCtrl.text.isEmpty) {
      return const FillAllFieldsFailure();
    }
    if (_passwordCtrl.text.length < _minPasswordLength) {
      return const PasswordTooShortFailure(minLength: _minPasswordLength);
    }
    if (_passwordCtrl.text != _passwordRepeatCtrl.text) {
      return const PasswordsDoNotMatchFailure();
    }
    return null;
  }

  Future<void> _submit() async {
    final validationFailure = _validate();
    if (validationFailure != null) {
      setState(() => _failure = validationFailure);
      return;
    }

    setState(() {
      _loading = true;
      _failure = null;
    });

    final result = await context.read<AuthCubit>().resetPassword(
      token: widget.token,
      newPassword: _passwordCtrl.text,
    );

    if (!mounted) return;

    switch (result) {
      case Success<void>():
        TextInput.finishAutofillContext(shouldSave: true);
        setState(() {
          _loading = false;
          _done = true;
        });
      case Failure<void>(:final failure):
        setState(() {
          _loading = false;
          _failure = failure;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.setNewPassword)),
      body: BottomBarLayoutWidget(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_done ? _buildDoneView(l10n) : _buildFormView(l10n)],
        ),
      ),
    );
  }

  Widget _buildDoneView(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, size: 64, color: Colors.green),
        const SizedBox(height: 16),
        Text(
          l10n.changedPassword,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go(RouteConfig.loginUrl),
            child: Text(l10n.loginNow),
          ),
        ),
      ],
    );
  }

  Widget _buildFormView(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.lock_reset,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          l10n.setNewPassword,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        AutofillGroup(
          child: Column(
            children: [
              TextField(
                controller: _passwordCtrl,
                enabled: !_loading,
                obscureText: true,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: l10n.newPassword),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordRepeatCtrl,
                enabled: !_loading,
                obscureText: true,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (!_loading) _submit();
                },
                decoration: InputDecoration(labelText: l10n.repeatPassword),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_failure != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              _failure!.localizedMessage(l10n),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
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
                : Text(l10n.savePassword),
          ),
        ),
      ],
    );
  }
}
