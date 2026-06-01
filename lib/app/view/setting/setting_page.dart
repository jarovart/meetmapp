import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:meetmaap/app/model/enums/appdesign.dart';
import 'package:meetmaap/app/view/model/draftsettings_model.dart';
import 'package:meetmaap/app/view/util/editrow.dart';
import 'package:meetmaap/app/view/util/infocard.dart';
import 'package:meetmaap/app/view/util/InfoRow.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const List<_LanguageOption> languages = [
    _LanguageOption(code: 'sys', label: 'System', icon: Icons.language),
    _LanguageOption(code: 'de', label: 'Deutsch', icon: Icons.flag_outlined),
    _LanguageOption(code: 'en', label: 'English', icon: Icons.flag_outlined),
  ];

  static const List<_DesignOption> designs = [
    _DesignOption(
      design: AppDesign.lightRose,
      label: 'Light Rose',
      icon: Icons.light_mode_outlined,
    ),
    _DesignOption(
      design: AppDesign.darkGold,
      label: 'Dark Gold',
      icon: Icons.dark_mode_outlined,
    ),
    _DesignOption(
      design: AppDesign.darkPink,
      label: 'Dark Pink',
      icon: Icons.favorite_border,
    ),
    _DesignOption(
      design: AppDesign.system,
      label: 'System',
      icon: Icons.settings_suggest_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final draft = context.select<SettingsController, DraftAppSettings>(
      (controller) => controller.draft,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<SettingsController>().saveSettings();
              },
              icon: const Icon(Icons.save_outlined),
              label: Text(l10n.save),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InfoCard(
            title: context.l10n.language,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: EditRow(
                icon: Icons.language,
                child: DropdownButton<String?>(
                  isExpanded: true,
                  value: context
                      .read<SettingsController>()
                      .locale
                      ?.languageCode,
                  items: [
                    DropdownMenuItem(value: "sys", child: Text("System")),
                    DropdownMenuItem(value: "de", child: Text("Deutsch")),
                    DropdownMenuItem(value: "en", child: Text("English")),
                  ],

                  onChanged: (value) {
                    context.read<SettingsController>().changeDraftLanguage(
                      value,
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          InfoCard(
            title: l10n.design,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: designs.map((option) {
                    return _DesignTile(
                      option: option,
                      selected: draft.design == option.design,
                      onTap: () {
                        context.read<SettingsController>().changeDraftDesign(
                          option.design,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectableInfoRow extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _SelectableInfoRow({
    required this.selected,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? colors.primary
              : colors.secondary.withValues(alpha: 0.25),
          width: selected ? 2 : 1,
        ),
      ),
      child: InfoRow(
        icon: selected ? Icons.check_circle_outline : icon,
        label: label,
        value: value,
        onTap: onTap,
      ),
    );
  }
}

class _DesignTile extends StatelessWidget {
  final _DesignOption option;
  final bool selected;
  final VoidCallback onTap;

  const _DesignTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? colors.primary
                : colors.secondary.withValues(alpha: 0.3),
            width: selected ? 2 : 1,
          ),
          color: selected
              ? colors.primary.withValues(alpha: 0.12)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.check_circle_outline : option.icon,
              color: selected ? colors.primary : colors.secondary,
            ),
            const SizedBox(height: 8),
            Text(
              option.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: selected ? colors.primary : colors.secondary,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption {
  final String? code;
  final String label;
  final IconData icon;

  const _LanguageOption({
    required this.code,
    required this.label,
    required this.icon,
  });
}

class _DesignOption {
  final AppDesign design;
  final String label;
  final IconData icon;

  const _DesignOption({
    required this.design,
    required this.label,
    required this.icon,
  });
}
