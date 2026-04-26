import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/controller/auth_controller.dart';
import 'package:meetmaap/app/controller/login_controller.dart';

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
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              : const Text('Ausloggen'),
        ),
      ),
    ];
  }

  List<Widget> loginWidgets(BuildContext context) {
    return [
      Text('Login', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16),

      AutofillGroup(
        child: Column(
          children: [
            TextField(
              controller: loginController.userCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            TextField(
              controller: loginController.passCtrl,
              decoration: const InputDecoration(labelText: 'Passwort'),
              autofillHints: const [AutofillHints.password],
              obscureText: true,
              onSubmitted: (_) => _submit(context),
            ),
          ],
        ),
      ),

      TextButton(
        onPressed: () => context.push(RouteConfig.forgotPasswordUrl),
        child: const Text('Passwort vergessen?'),
      ),

      const SizedBox(height: 16),
      if (loginController.hasErrors)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            loginController.errorMessage,
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
              context.push(RouteConfig.registerUrl);
            },
            child: const Text('Registrieren'),
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
    if (redirectionUrl == null) {
      context.pop(true);
      return;
    }

    final returnedValue = await context.push(redirectionUrl!);
    if (context.mounted) context.pop(returnedValue);
  }
}
