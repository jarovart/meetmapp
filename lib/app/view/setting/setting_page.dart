import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:meetmaap/app/model/enums/appdesign.dart';
import 'package:meetmaap/app/model/enums/language.dart';
import 'package:meetmaap/app/view/design/themedesign.dart';
import 'package:meetmaap/app/view/model/designoption.dart';
import 'package:meetmaap/app/view/model/draftsettings_model.dart';
import 'package:meetmaap/app/view/model/languageoption.dart';
import 'package:meetmaap/app/view/util/designtile.dart';
import 'package:meetmaap/app/view/util/editrow.dart';
import 'package:meetmaap/app/view/util/infocard.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:meetmaap/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("building settings page");
    final draft = context.select<SettingsController, DraftAppSettings>(
      (controller) => controller.draft,
    );

    final previewTheme = ThemeDesign.getPreviewThemeByAppDesign(
      draft.design,
      MediaQuery.of(context).platformBrightness,
    );

    final languageValue = draft.locale?.languageCode ?? LanguageEnum.sys.name;

    return Localizations.override(
      context: context,
      locale: resolvePreviewLocale(draft.locale),
      child: Theme(
        data: previewTheme,
        child: Builder(
          builder: (context) {
            final l10n = context.l10n;
            List<LanguageOption> languages = createLanguageOptions(l10n);

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
                          value: languageValue,
                          items: languages.map((option) {
                            return DropdownMenuItem(
                              value: option.code,
                              child: Text(option.label),
                            );
                          }).toList(),
                          onChanged: (value) {
                            context
                                .read<SettingsController>()
                                .changeDraftLanguage(value);
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
                          children: createDesignOptions(l10n).map((option) {
                            return DesignTile(
                              option: option,
                              selected: draft.design == option.design,
                              onTap: () {
                                context
                                    .read<SettingsController>()
                                    .changeDraftDesign(option.design);
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
          },
        ),
      ),
    );
  }

  Locale resolvePreviewLocale(Locale? draftLocale) {
    if (draftLocale != null) {
      return draftLocale;
    }

    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;

    final supported = AppLocalizations.supportedLocales;

    return supported.firstWhere(
      (locale) => locale.languageCode == systemLocale.languageCode,
      orElse: () => supported.first,
    );
  }

  List<LanguageOption> createLanguageOptions(AppLocalizations l10n) {
    return [
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
  }

  List<DesignOption> createDesignOptions(AppLocalizations l10n) {
    return [
      DesignOption(
        design: AppDesign.lightBlack,
        label: 'Light Black',
        icon: Icons.light_mode_outlined,
      ),
      DesignOption(
        design: AppDesign.lightRose,
        label: 'Light Rose',
        icon: Icons.light_mode_outlined,
      ),
      DesignOption(
        design: AppDesign.lightWine,
        label: 'Light Wine',
        icon: Icons.light_mode_outlined,
      ),
      DesignOption(
        design: AppDesign.darkGold,
        label: 'Dark Gold',
        icon: Icons.dark_mode_outlined,
      ),
      DesignOption(
        design: AppDesign.darkPink,
        label: 'Dark Pink',
        icon: Icons.favorite_border,
      ),
      DesignOption(
        design: AppDesign.system,
        label: 'System',
        icon: Icons.settings_suggest_outlined,
      ),
      //next update: custom settings.
    ];
  }
}
