import 'dart:async';

import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCheckEmailPage extends StatefulWidget {
  const RegisterCheckEmailPage({super.key, required this.email});

  final String email;

  @override
  State<RegisterCheckEmailPage> createState() => _RegisterCheckEmailPageState();
}

class _RegisterCheckEmailPageState extends State<RegisterCheckEmailPage> {
  bool _loading = false;
  AppFailure? _failure;
  int _cooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  Future<void> _resend() async {
    setState(() {
      _loading = true;
      _failure = null;
    });

    final result = await context.read<AuthCubit>().resendVerificationEmail(
      email: widget.email,
      languageCode: _currentLanguageCode(),
    );

    if (!mounted) return;

    switch (result) {
      case Success<void>():
        setState(() => _loading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.resentEmail)));
      case Failure<void>(:final failure):
        if (failure is CooldownFailure) {
          context.read<AppBannerCubit>().showFailure(failure);
          _startCooldown(failure.waitSeconds);
        } else {
          setState(() {
            _failure = failure;
          });
        }
        setState(() {
          _loading = false;
        });
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

  String _currentLanguageCode() {
    final settings = context.read<AppSettingsCubit>().state;
    final locale =
        settings.locale ?? WidgetsBinding.instance.platformDispatcher.locale;
    return locale.languageCode.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;
    final isDisabled = _loading || _cooldown > 0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.register)),
      body: BottomBarLayoutWidget(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mark_email_read, size: 64, color: colors.primary),
            const SizedBox(height: 16),
            Text(
              l10n.registrationSuccessful,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              l10n.verificationMailSentTo(widget.email),
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
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
              child: ElevatedButton(
                onPressed: isDisabled ? null : _resend,
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _cooldown > 0
                            ? l10n.waitForXSeconds(_cooldown)
                            : l10n.resendEmail,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
