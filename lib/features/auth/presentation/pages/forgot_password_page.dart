import 'dart:async';

import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  static const _resendCooldownSeconds = 60;

  final _emailCtrl = TextEditingController();

  bool _loading = false;
  bool _sent = false;
  AppFailure? _failure;
  int _cooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  AppFailure? _validate() {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !email.contains('@') || email.contains(' ')) {
      return const InvalidEmailFailure();
    }
    return null;
  }

  String _currentLanguageCode() {
    final settings = context.read<AppSettingsCubit>().state;
    final locale =
        settings.locale ?? WidgetsBinding.instance.platformDispatcher.locale;
    return locale.languageCode.toUpperCase();
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

    final result = await context.read<AuthCubit>().forgotPassword(
      email: _emailCtrl.text.trim(),
      languageCode: _currentLanguageCode(),
    );

    if (!mounted) return;

    switch (result) {
      case Success<void>():
        setState(() {
          _loading = false;
          _sent = true;
        });
        _startCooldown(_resendCooldownSeconds);
      case Failure<void>(:final failure):
        setState(() {
          _loading = false;
          _failure = failure;
        });
        if (failure is CooldownFailure) {
          _startCooldown(failure.waitSeconds);
        }
    }
  }

  void _startCooldown(int seconds) {
    _cooldownTimer?.cancel();
    setState(() => _cooldown = seconds);

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_cooldown <= 1) {
        timer.cancel();
        setState(() {
          _cooldown = 0;
          _failure = null;
        });
      } else {
        setState(() => _cooldown--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.forgotPassword)),
      body: BottomBarLayoutWidget(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_sent ? _buildSentView(l10n) : _buildFormView(l10n)],
        ),
      ),
    );
  }

  Widget _buildSentView(AppLocalizations l10n) {
    final isDisabled = _loading || _cooldown > 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.mark_email_read, size: 64, color: Colors.green),
        const SizedBox(height: 16),
        Text(
          l10n.linkSendToEmail,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          _emailCtrl.text.trim(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
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
          child: OutlinedButton(
            onPressed: isDisabled ? null : _submit,
            child: Text(
              _cooldown > 0
                  ? l10n.waitForXSeconds(_cooldown)
                  : l10n.resendEmail,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => context.go(RouteConfig.loginUrl),
            child: Text(l10n.login),
          ),
        ),
      ],
    );
  }

  Widget _buildFormView(AppLocalizations l10n) {
    final isDisabled = _loading || _cooldown > 0;

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
          l10n.forgotPassword,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.forgotPasswordHint,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        AutofillGroup(
          child: TextField(
            controller: _emailCtrl,
            enabled: !_loading,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              if (!isDisabled) _submit();
            },
            decoration: InputDecoration(labelText: l10n.email),
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
            onPressed: isDisabled ? null : _submit,
            child: _loading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _cooldown > 0
                        ? l10n.waitForXSeconds(_cooldown)
                        : l10n.sendLink,
                  ),
          ),
        ),
      ],
    );
  }
}
