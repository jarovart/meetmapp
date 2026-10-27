import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/widget/bottombar_layout_widget.dart';
import 'package:casttime/features/support/widget/support_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return BottomBarLayoutWidget(
      childWidget: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.support_agent_outlined, size: 64, color: colors.primary),
          const SizedBox(height: 16),
          Text(
            l10n.howToSupport,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(l10n.sendEmail, textAlign: TextAlign.center),
          const SizedBox(height: 28),
          SupportCard(
            icon: Icons.email_outlined,
            title: l10n.writeEmail,
            subtitle: l10n.openMailProgramm,
            child: FilledButton.icon(
              onPressed: _openMailApp,
              icon: const Icon(Icons.open_in_new),
              label: Text(l10n.contactSupport),
            ),
          ),
          // const SizedBox(height: 16),
          // const DirectMessageCard(),   // TODO: activate after backendexpansion
        ],
      ),
    );
  }

  Future<void> _openMailApp() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'info@jarovart.de',
      queryParameters: {'subject': 'Supportrequest'},
    );
    await launchUrl(uri);
  }
}
