import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/navigation/util/route_config.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum _VerifyStatus { verifying, success, failure }

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key, required this.token});

  final String token;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  _VerifyStatus _status = _VerifyStatus.verifying;
  AppFailure? _failure;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _verify());
  }

  Future<void> _verify() async {
    setState(() {
      _status = _VerifyStatus.verifying;
      _failure = null;
    });

    final result = await context.read<AuthCubit>().verifyEmail(widget.token);

    if (!mounted) return;

    switch (result) {
      case Success<void>():
        setState(() => _status = _VerifyStatus.success);
      case Failure<void>(:final failure):
        setState(() {
          _status = _VerifyStatus.failure;
          _failure = failure;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.verifyEmail)),
      body: BottomBarLayoutWidget(
        childWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            switch (_status) {
              _VerifyStatus.verifying => const _VerifyingView(),
              _VerifyStatus.success => const _SuccessView(),
              _VerifyStatus.failure => _FailureView(
                failure: _failure,
                onRetry: _verify,
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _VerifyingView extends StatelessWidget {
  const _VerifyingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 24),
        Text(context.l10n.verifyingEmail, textAlign: TextAlign.center),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 64),
        const SizedBox(height: 16),
        Text(
          l10n.registerSuccessfully,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
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
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.failure, required this.onRetry});

  final AppFailure? failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          size: 64,
        ),
        const SizedBox(height: 16),
        Text(
          failure?.localizedMessage(l10n) ?? l10n.verifcationFailed,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: onRetry, child: Text(l10n.retry)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => context.go(RouteConfig.mapUrl),
            child: Text(l10n.backtToHomepage),
          ),
        ),
      ],
    );
  }
}
