import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meetmaap/app/config/route_config.dart';
import 'package:meetmaap/app/service/authentication_service.dart';
import 'package:meetmaap/app/view/util/app_errormessage_mapper.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';

class VerifyPage extends StatefulWidget {
  final String token;

  const VerifyPage({super.key, required this.token});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool _loading = false;
  bool _verified = false;
  String? _error;

  @override
  void initState() {
    super.initState();

    AuthService.verifyEmail(widget.token)
        .then((_) {
          if (!mounted) return;
          setState(() {
            _verified = true;
          });
        })
        .catchError((e) {
          if (!mounted) return;
          debugPrint('Error while verify email: $e');
          setState(
            () => _error = AppErrorMapper.toUserMessage(
              e,
              context.l10n,
              fallback: context.l10n.verifcationFailed,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (!_verified) {
      return Scaffold(
        appBar: AppBar(title: Text(context.l10n.verifyEmail)),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_loading) const CircularProgressIndicator(),
                  if (_error != null)
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  if (_error != null)
                    ElevatedButton(
                      onPressed: () {
                        context.go(RouteConfig.homePageUrl);
                      },
                      child: Text(context.l10n.backtToHomepage),
                    ),
                  if (!_loading && _error == null)
                    Text(context.l10n.verifyingEmail),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.login)),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64),
                Text(context.l10n.registerSuccessfully),
                ElevatedButton(
                  onPressed: () {
                    context.go(RouteConfig.loginUrl);
                  },
                  child: Text(context.l10n.loginNow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
