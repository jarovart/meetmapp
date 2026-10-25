import 'package:casttime/app/theme/appdesign.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DesignOption {
  final AppDesign design;
  final String label;
  final IconData icon;

  const DesignOption({
    required this.design,
    required this.label,
    required this.icon,
  });
}

List<DesignOption> createDesignOptions(AppLocalizations l10n) {
  return [
    DesignOption(
      design: AppDesign.lightBlack,
      label: l10n.designLightBlack,
      icon: Icons.light_mode_outlined,
    ),
    DesignOption(
      design: AppDesign.lightRose,
      label: l10n.designLightRose,
      icon: Icons.light_mode_outlined,
    ),
    DesignOption(
      design: AppDesign.lightWine,
      label: l10n.designLightWine,
      icon: Icons.light_mode_outlined,
    ),
    DesignOption(
      design: AppDesign.darkGold,
      label: l10n.designDarkGold,
      icon: Icons.dark_mode_outlined,
    ),
    DesignOption(
      design: AppDesign.darkPink,
      label: l10n.designDarkPink,
      icon: Icons.favorite_border,
    ),
    DesignOption(
      design: AppDesign.system,
      label: l10n.designDefault,
      icon: Icons.settings_suggest_outlined,
    ),
  ];
}
