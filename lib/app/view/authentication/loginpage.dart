import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/login_controller.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';

class LoginPage extends StatelessWidget {
  final String? redirectionUrl;
  final LoginController loginController;
  final AuthController authController;

  LoginPage({
    super.key,
    required this.loginController,
    required this.authController,
    this.redirectionUrl,
  });

  @override
  Widget build(BuildContext context) {
    if (loginController.loading) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.login)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.login)),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: loginController.loggedIn
                    ? logoutWidgets(context)
                    : loginWidgets(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> logoutWidgets(BuildContext context) {
    return [
      Text('Logout', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16),
      Text('Eingeloggt als ${loginController.myUserName}'),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: loginController.loading
              ? null
              : () => loginController.submitLogout(authController),
          child: loginController.loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(context.l10n.logout),
        ),
      ),
    ];
  }

  List<Widget> loginWidgets(BuildContext context) {
    return [
      Text(
        context.l10n.login,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 16),

      AutofillGroup(
        child: Column(
          children: [
            TextField(
              controller: loginController.userCtrl,
              decoration: InputDecoration(labelText: context.l10n.username),
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.email,
              ],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: loginController.passCtrl,
              decoration: InputDecoration(labelText: context.l10n.password),
              autofillHints: const [AutofillHints.password],
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(context),
            ),
          ],
        ),
      ),

      TextButton(
        onPressed: () => context.push(RouteConfig.forgotPasswordUrl),
        child: Text(context.l10n.forgotPasswordQuestion),
      ),

      const SizedBox(height: 16),
      if (loginController.hasErrors)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            AppErrorMapper.toUserMessage(
              loginController.error!,
              context.l10n,
              fallback: context.l10n.errorLogin,
            ),
            style: const TextStyle(color: Colors.red),
          ),
        ),

      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: loginController.loading ? null : () => _submit(context),
          child: loginController.loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(context.l10n.login),
        ),
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.l10n.noAccountQuestion),
          TextButton(
            onPressed: () {
              context.push(RouteConfig.registerUrl);
            },
            child: Text(context.l10n.register),
          ),
        ],
      ),
    ];
  }

  void _submit(BuildContext context) async {
    debugPrint("Redirection URL: $redirectionUrl");

    await loginController.submit(authController);

    if (!context.mounted) return;
    if (loginController.hasErrors) return;
    TextInput.finishAutofillContext(shouldSave: true);
    if (redirectionUrl == null) {
      context.pop(true);
      return;
    }

    final returnedValue = await context.push(redirectionUrl!);
    if (context.mounted) context.pop(returnedValue);
  }
}
