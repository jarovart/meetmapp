import 'package:flutter/material.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:meetmaap/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController _messageCtrl = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _openMailApp() async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'info@jarovart.de',
      queryParameters: {'subject': 'Supportrequest'},
    );

    await launchUrl(uri);
  }

  Future<void> _sendDirectMessage(AppLocalizations l10n) async {
    final message = _messageCtrl.text.trim();
    if (message.isEmpty) return;

    setState(() => _isSending = true);

    try {
      // await SupportService.sendMessage(message);

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      _messageCtrl.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.messageSent)));
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.messageFailed)));
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.support)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.support_agent_outlined,
                  size: 64,
                  color: colors.primary,
                ),
                const SizedBox(height: 16),

                Text(
                  l10n.howToSupport,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(l10n.sendEmail, textAlign: TextAlign.center),

                const SizedBox(height: 28),

                _SupportCard(
                  icon: Icons.email_outlined,
                  title: l10n.writeEmail,
                  subtitle: l10n.openMailProgramm,
                  child: FilledButton.icon(
                    onPressed: _openMailApp,
                    icon: const Icon(Icons.open_in_new),
                    label: Text(l10n.contactSupport),
                  ),
                ),

                const SizedBox(height: 16),

                /*if (false)
                _SupportCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Direktnachricht',
                  subtitle: 'Beschreibe dein Problem möglichst genau.',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _messageCtrl,
                        minLines: 5,
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'Deine Nachricht...',
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      FilledButton.icon(
                        onPressed: _isSending
                            ? null
                            : () async => await _sendDirectMessage(l10n),
                        icon: _isSending
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.send_outlined),
                        label: Text(_isSending ? 'Wird gesendet...' : 'Senden'),
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  const _SupportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 60),

              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(subtitle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}
