import 'package:flutter/material.dart';
import 'package:meetmaap/app/controller/setting_controller.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = context.watch<SettingsController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text('Dunkler Modus'),
              value: settingsController.isDarkMode,
              onChanged: (value) {
                settingsController.setDarkMode(value);
              },
            ),
            ListTile(
              title: const Text('Sprache'),
              subtitle: Text(settingsController.language),
              onTap: () {
                // Logik zum Ändern der Sprache
              },
            ),
          ],
        ),
      ),
    );
  }
}
