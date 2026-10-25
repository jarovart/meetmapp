import 'package:casttime/app/di/injection.dart';
import 'package:casttime/app/localization/app_failure_localization.dart';
import 'package:casttime/app/localization/l10n_extension.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/app/theme/themedesign.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_bloc.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_event.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_state.dart';
import 'package:casttime/features/setting/presentation/page/widget/design_card.dart';
import 'package:casttime/features/setting/presentation/page/widget/language_card.dart';
import 'package:casttime/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsFormBloc>()..add(SettingsFormStarted()),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsFormBloc, SettingsFormState>(
      builder: (context, state) {
        if (state.status == LoadStatus.initial ||
            state.status == LoadStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final previewTheme = ThemeDesign.getPreviewThemeByAppDesign(
          state.draft.design,
          MediaQuery.of(context).platformBrightness,
        );

        return Localizations.override(
          context: context,
          locale: _resolvePreviewLocale(state.draft.locale),
          child: Theme(
            data: previewTheme,
            child: Builder(
              builder: (context) => _SettingsScaffold(state: state),
            ),
          ),
        );
      },
    );
  }

  Locale _resolvePreviewLocale(Locale? draftLocale) {
    if (draftLocale != null) return draftLocale;

    final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final supported = AppLocalizations.supportedLocales;

    return supported.firstWhere(
      (locale) => locale.languageCode == systemLocale.languageCode,
      orElse: () => supported.first,
    );
  }
}

class _SettingsScaffold extends StatelessWidget {
  const _SettingsScaffold({required this.state});

  final SettingsFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton.icon(
              onPressed: (state.isSaving || !state.hasChanges)
                  ? null
                  : () => context.read<SettingsFormBloc>().add(
                      SettingsSubmitted(),
                    ),
              icon: state.isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(l10n.save),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 550),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (state.failure != null) ...[
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      state.failure!.localizedMessage(l10n),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
              LanguageCard(locale: state.draft.locale),
              const SizedBox(height: 18),
              DesignCard(design: state.draft.design),
            ],
          ),
        ),
      ),
    );
  }
}
