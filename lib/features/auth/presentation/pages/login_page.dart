// features/auth/presentation/pages/login_page.dart
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.redirectionUrl});

  final String? redirectionUrl;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _loading = false;
  AppFailure? _failure;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _failure = null;
    });

    final result = await context.read<AuthCubit>().login(
      username: _userCtrl.text.trim(),
      password: _passCtrl.text,
    );

    if (!mounted) return;

    switch (result) {
      case Success<void>():
        TextInput.finishAutofillContext(shouldSave: true);
        await context.read<AppSettingsCubit>().syncFromServer();
        if (!mounted) return;
        _navigateAfterLogin(context.read<AuthCubit>().state.userId!);
      case Failure<void>(:final failure):
        setState(() {
          _loading = false;
          _failure = failure;
        });
    }
  }

  void _navigateAfterLogin(int userId) {
    if (widget.redirectionUrl == null) {
      context.pushReplacement(RouteConfig.myProfileUrl, extra: userId);
      return;
    }
    context.pushReplacement(widget.redirectionUrl!);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BottomBarLayoutWidget(
      childWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              l10n.login,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),

          AutofillGroup(
            child: Column(
              children: [
                TextField(
                  controller: _userCtrl,
                  decoration: InputDecoration(labelText: l10n.username),
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  textInputAction: TextInputAction.next,
                  enabled: !_loading,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passCtrl,
                  decoration: InputDecoration(labelText: l10n.password),
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  enabled: !_loading,
                  onSubmitted: (_) => _submit(),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: () => context.push(RouteConfig.forgotPasswordUrl),
            child: Text(l10n.forgotPasswordQuestion),
          ),

          const SizedBox(height: 16),
          if (_failure != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _failure!.localizedMessage(l10n),
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
                  : Text(l10n.login),
            ),
          ),

          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(l10n.noAccountQuestion),
              TextButton(
                onPressed: () => context.push(RouteConfig.registerUrl),
                child: Text(l10n.register),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
