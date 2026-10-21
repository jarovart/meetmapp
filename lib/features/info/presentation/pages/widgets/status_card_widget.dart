import 'package:casttime/app/config/app_config.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/features/info/presentation/bloc/info_bloc.dart';
import 'package:casttime/features/info/presentation/bloc/info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusCard extends StatelessWidget {
  const StatusCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        final status = state.appStatus;

        return Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.tag),
                title: Text(l10n.version),
                trailing: Text(AppConfig.version),
              ),
              const Divider(height: 1),
              if (state.status == LoadStatus.loading)
                const ListTile(
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  title: Text(''),
                )
              else if (state.status == LoadStatus.failure)
                ListTile(
                  leading: const Icon(Icons.cloud_off, color: Colors.red),
                  title: Text(l10n.server),
                  trailing: Text(l10n.offline),
                )
              else if (status != null) ...[
                if (status.serverVersion != null) ...[
                  ListTile(
                    leading: const Icon(Icons.toggle_on_sharp),
                    title: Text(l10n.serverVersion),
                    trailing: Text(status.serverVersion!),
                  ),
                  const Divider(height: 1),
                ],
                ListTile(
                  leading: Icon(
                    Icons.cloud_done,
                    color: status.serverOnline ? Colors.green : Colors.red,
                  ),
                  title: Text(l10n.server),
                  trailing: Text(
                    status.serverOnline ? l10n.online : l10n.offline,
                  ),
                ),
                if (status.databaseOnline != null) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(
                      Icons.storage,
                      color: status.databaseOnline! ? Colors.green : Colors.red,
                    ),
                    title: Text(l10n.database),
                    trailing: Text(
                      status.databaseOnline! ? l10n.online : l10n.offline,
                    ),
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }
}
