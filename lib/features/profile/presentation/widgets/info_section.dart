import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String? aboutMe;

  InfoSection({super.key, this.aboutMe});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.aboutMe,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                aboutMe?.isNotEmpty == true
                    ? aboutMe!
                    : l10n.noDescriptionAvailable,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
