import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomepageCard extends StatelessWidget {
  const HomepageCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: ListTile(
        leading: const Icon(Icons.diamond_outlined),
        title: Text(l10n.homepage),
        subtitle: const Text('jarovart.de'),
        trailing: const Icon(Icons.open_in_new),
        onTap: () => launchUrl(
          Uri.parse('https://jarovart.de'),
          mode: LaunchMode.externalApplication,
        ),
      ),
    );
  }
}
