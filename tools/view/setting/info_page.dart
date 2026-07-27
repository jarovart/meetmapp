import 'package:flutter/material.dart';

import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/controller/info_controller.dart';
import 'package:casttime/extensions/l10n_extension.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final infoController = context.watch<InfoController>();
    final l10n = context.l10n;
    final version = AppConfig.version;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.info)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 8),

              Center(
                child: Image.asset(
                  AppConfig.appIconPath,
                  width: 72,
                  height: 72,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                AppConfig.appName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.tag),
                      title: Text(l10n.version),
                      trailing: Text(version),
                    ),
                    const Divider(height: 1),
                    if (infoController.statusResponse?.serverVersion !=
                        null) ...[
                      ListTile(
                        leading: const Icon(Icons.toggle_on_sharp),
                        title: Text(l10n.serverVersion),
                        trailing: Text(
                          infoController.statusResponse?.serverVersion ?? '',
                        ),
                      ),
                      const Divider(height: 1),
                    ],
                    ListTile(
                      leading: Icon(
                        Icons.cloud_done,
                        color:
                            infoController.statusResponse?.serverOnline ?? false
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(l10n.server),
                      trailing: Text(
                        infoController.statusResponse?.serverOnline ?? false
                            ? l10n.online
                            : l10n.offline,
                      ),
                    ),
                    if (infoController.statusResponse?.dataBaseOnline !=
                        null) ...[
                      const Divider(height: 1),
                      ListTile(
                        leading: Icon(
                          Icons.storage,
                          color:
                              infoController.statusResponse?.dataBaseOnline ??
                                  false
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(l10n.database),
                        trailing: Text(
                          infoController.statusResponse?.dataBaseOnline ?? false
                              ? l10n.online
                              : l10n.offline,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.aboutApp(AppConfig.appName),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(l10n.aboutAppText(AppConfig.appName)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.diamond_outlined),
                      title: Text(l10n.homepage),
                      subtitle: const Text("jarovart.de"),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: _openHomepage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openHomepage() async {
    await launchUrl(
      Uri.parse('https://jarovart.de'),
      mode: LaunchMode.externalApplication,
    );
  }
}
