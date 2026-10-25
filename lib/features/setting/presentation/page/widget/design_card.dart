import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/theme/appdesign.dart';
import 'package:casttime/app/theme/design_options.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_bloc.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_event.dart';
import 'package:casttime/features/setting/presentation/page/widget/design_tile.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DesignCard extends StatelessWidget {
  const DesignCard({required this.design});

  final AppDesign design;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return InfoCard(
      title: l10n.design,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final option in createDesignOptions(l10n))
                DesignTile(
                  option: option,
                  selected: design == option.design,
                  onTap: () => context.read<SettingsFormBloc>().add(
                    SettingsDesignChanged(option.design),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
