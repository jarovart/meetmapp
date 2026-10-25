import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LanguageOption {
  final String? code;
  final String label;
  final IconData icon;

  const LanguageOption({
    required this.code,
    required this.label,
    required this.icon,
  });
}

enum LanguageEnum { sys, de, en }

List<LanguageOption> createLanguageOptions(AppLocalizations l10n) => [
  LanguageOption(
    code: LanguageEnum.sys.name,
    label: l10n.systemLanguage,
    icon: Icons.language,
  ),
  LanguageOption(
    code: LanguageEnum.de.name,
    label: l10n.german,
    icon: Icons.flag_outlined,
  ),
  LanguageOption(
    code: LanguageEnum.en.name,
    label: l10n.english,
    icon: Icons.flag_outlined,
  ),
];
