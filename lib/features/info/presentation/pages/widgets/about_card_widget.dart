import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.aboutApp(AppConfig.appName),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(l10n.aboutAppText(AppConfig.appName)),
          ],
        ),
      ),
    );
  }
}
