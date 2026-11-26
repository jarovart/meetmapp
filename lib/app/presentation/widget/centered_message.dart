// app/presentation/widget/centered_message.dart
import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  const CenteredMessage({
    super.key,
    required this.message,
    this.isError = false,
    this.onRetry,
  });

  final String message;
  final bool isError;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          32,
          32,
          32,
          AppConfig.maxNavigationDockBarHeight,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: isError
                  ? TextStyle(color: Theme.of(context).colorScheme.error)
                  : null,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onRetry,
                child: Text(context.l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
