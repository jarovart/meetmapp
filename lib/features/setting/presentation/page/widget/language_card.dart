import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/localization/language_options.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_bloc.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_event.dart';
import 'package:casttime/features/setting/presentation/page/widget/edit_row.dart';
import 'package:casttime/features/setting/presentation/page/widget/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCard extends StatelessWidget {
  const LanguageCard({required this.locale});

  final Locale? locale;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = locale?.languageCode ?? LanguageEnum.sys.name;

    return InfoCard(
      title: l10n.language,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: EditRow(
          icon: Icons.language,
          child: DropdownButton<String?>(
            isExpanded: true,
            value: value,
            items: [
              for (final option in createLanguageOptions(l10n))
                DropdownMenuItem(value: option.code, child: Text(option.label)),
            ],
            onChanged: (value) => context.read<SettingsFormBloc>().add(
              SettingsLanguageChanged(value),
            ),
          ),
        ),
      ),
    );
  }
}
