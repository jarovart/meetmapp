import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';

class UploadOverlay extends StatelessWidget {
  const UploadOverlay({super.key, this.messageKey});

  final String? messageKey;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ;

    final message = switch (messageKey) {
      'savingLocation' => l10n.savingLocation,
      'uploadingImages' => l10n.uploadingImages,
      'settingThumbnail' => l10n.settingThumbnail,
      _ => l10n.loading,
    };

    return Positioned.fill(
      child: AbsorbPointer(
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.5),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
