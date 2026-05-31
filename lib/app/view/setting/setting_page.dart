import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:meetmaap/app/view/model/appliedsettings_model.dart';
import 'package:meetmaap/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();
    final appliedSettings = context
        .select<SettingsController, AppliedAppSettings?>(
          (controller) => controller.appliedSetting,
        );
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text(l10n.darkMode),
              value: settingsController.isDarkMode,
              onChanged: (value) {
                settingsController.setDarkMode(value);
              },
            ),
            ListTile(
              title: Text(l10n.language),
              subtitle: Text(settingsController.language),
              onTap: () {
                // Logik zum Ändern der Sprache
              },
            ),
            DropdownButton<String?>(
              value: settingsController.locale?.languageCode,

              items: const [
                DropdownMenuItem(value: null, child: Text("System")),

                DropdownMenuItem(value: "de", child: Text("Deutsch")),

                DropdownMenuItem(value: "en", child: Text("English")),
              ],

              onChanged: (value) {
                settingsController.changeDraftLanguage(value);

                // später Backend speichern
                // await settingsApi.saveLanguage(value);
              },
            ),
            ElevatedButton(
              onPressed: () {
                settingsController.saveSettings();
              },
              child: Text(context.l10n.save),
            ),
          ],
        ),
      ),
    );
  }
}
