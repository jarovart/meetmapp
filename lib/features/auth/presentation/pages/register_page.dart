// features/auth/presentation/pages/register_page.dart
import 'dart:async';

import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/banner/appbanner_cubit.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const _minPasswordLength = 8;

  final _userCtrl = TextEditingController();
  final _firstnameCtrl = TextEditingController();
  final _lastnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _passRepeatCtrl = TextEditingController();

  bool _loading = false;
  AppFailure? _failure;
  int _cooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _userCtrl.dispose();
    _firstnameCtrl.dispose();
    _lastnameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _passRepeatCtrl.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  AppFailure? _validate() {
    final fields = [
      _userCtrl.text.trim(),
      _firstnameCtrl.text.trim(),
      _lastnameCtrl.text.trim(),
      _emailCtrl.text.trim(),
      _passCtrl.text,
      _passRepeatCtrl.text,
    ];
    if (fields.any((f) => f.isEmpty)) {
      return const FillAllFieldsFailure();
    }
    if (_passCtrl.text != _passRepeatCtrl.text) {
      return const PasswordsDoNotMatchFailure();
    }
    if (_passCtrl.text.length < _minPasswordLength) {
      return const PasswordTooShortFailure();
    }
    final email = _emailCtrl.text.trim();
    if (email.contains(' ') || !email.contains('@')) {
      return const InvalidEmailFailure();
    }
    return null;
  }

  Future<void> _submit() async {
    final validationFailure = _validate();
    if (validationFailure != null) {
      context.read<AppBannerCubit>().showFailure(validationFailure);
      return;
    }

    setState(() {
      _loading = true;
      _failure = null;
    });

    final email = _emailCtrl.text.trim();
    final result = await context.read<AuthCubit>().register(
      username: _userCtrl.text.trim(),
      firstname: _firstnameCtrl.text.trim(),
      lastname: _lastnameCtrl.text.trim(),
      email: email,
      password: _passCtrl.text,
      languageCode: _currentLanguageCode(),
    );

    if (!mounted) return;

    switch (result) {
      case Success<void>():
        TextInput.finishAutofillContext(shouldSave: true);
        context.push(RouteConfig.sendRegisterEmailUrl, extra: email);
      case Failure<void>(:final failure):
        if (failure is CooldownFailure) {
          setState(() {
            _loading = false;
            _failure = failure;
          });
          _startCooldown(failure.waitSeconds);
        } else {
          context.read<AppBannerCubit>().showFailure(failure);
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
    final isDisabled = _loading || _cooldown > 0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.register)),
      body: BottomBarLayoutWidget(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.register,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            AutofillGroup(
              child: Column(
                children: [
                  TextField(
                    controller: _userCtrl,
                    enabled: !_loading,
                    autofillHints: const [AutofillHints.newUsername],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: l10n.username),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstnameCtrl,
                          enabled: !_loading,
                          autofillHints: const [AutofillHints.givenName],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: l10n.firstName,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _lastnameCtrl,
                          enabled: !_loading,
                          autofillHints: const [AutofillHints.familyName],
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: l10n.familyName,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailCtrl,
                    enabled: !_loading,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: l10n.email),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passCtrl,
                    enabled: !_loading,
                    obscureText: true,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: l10n.password),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passRepeatCtrl,
                    enabled: !_loading,
                    obscureText: true,
                    autofillHints: const [AutofillHints.newPassword],
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => isDisabled ? null : _submit,
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
                            : l10n.register,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
