import 'dart:ui';

import 'package:casttime/app/localization/language_options.dart';
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/storage/preferences_repository.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';
import 'package:casttime/features/setting/domain/repository/settings_repository.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_event.dart';
import 'package:casttime/features/setting/presentation/bloc/settings_form_state.dart';
import 'package:casttime/features/setting/presentation/cubit/app_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SettingsFormBloc extends Bloc<SettingsFormEvent, SettingsFormState> {
  SettingsFormBloc(
    this._authCubit,
    this._appSettingsCubit,
    this._settingsRepository,
    this._preferencesRepository,
  ) : super(
        SettingsFormState(
          draft: AppSettings(updatedAt: DateTime.utc(1970)),
          saved: AppSettings(updatedAt: DateTime.utc(1970)),
        ),
      ) {
    on<SettingsFormStarted>(_onStarted);
    on<SettingsDesignChanged>(_onDesignChanged);
    on<SettingsLanguageChanged>(_onLanguageChanged);
    on<SettingsSubmitted>(_onSubmitted);
  }
  final AuthCubit _authCubit;
  final AppSettingsCubit _appSettingsCubit;
  final SettingsRepository _settingsRepository;
  final PreferencesRepository _preferencesRepository;

  Future<void> _onStarted(
    SettingsFormStarted event,
    Emitter<SettingsFormState> emit,
  ) async {
    final current = _appSettingsCubit.state;
    emit(
      state.copyWith(
        status: LoadStatus.loading,
        draft: current,
        saved: current,
      ),
    );

    AppSettings? localSettings;
    AppSettings? remoteSettings;
    bool isLoggedIn = _authCubit.state.isLoggedIn;

    if (isLoggedIn) {
      final result = await _settingsRepository.loadRemote();
      switch (result) {
        case Success<AppSettings>(:final data):
          remoteSettings = data;
        case Failure<AppSettings>(:final failure):
          debugPrint("Error loading settings from backend: $failure");
      }
    }
    localSettings = await _preferencesRepository.readLocalSettings();
    debugPrint("local setting: $localSettings");
    debugPrint("backend setting: $remoteSettings");
    final newest = chooseNewest(localSettings, remoteSettings);

    emit(
      state.copyWith(status: LoadStatus.success, draft: newest, saved: newest),
    );
  }

  void _onDesignChanged(
    SettingsDesignChanged event,
    Emitter<SettingsFormState> emit,
  ) {
    emit(state.copyWith(draft: state.draft.copyWith(design: event.design)));
  }

  void _onLanguageChanged(
    SettingsLanguageChanged event,
    Emitter<SettingsFormState> emit,
  ) {
    final code = event.languageCode;
    final locale = (code == null || code == LanguageEnum.sys.name)
        ? null
        : Locale(code);
    emit(state.copyWith(draft: state.draft.copyWith(locale: locale)));
  }

  Future<void> _onSubmitted(
    SettingsSubmitted event,
    Emitter<SettingsFormState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, failure: null));

    if (_authCubit.state.isLoggedIn) {
      await _settingsRepository.saveRemote(state.draft);
    }
    final result = await _preferencesRepository.saveLocalSettings(state.draft);
    if (result) {
      await _appSettingsCubit.apply(state.draft);
      emit(
        state.copyWith(isSaving: false, draft: state.draft, saved: state.draft),
      );
    } else {
      emit(state.copyWith(isSaving: false));
    }
  }

  AppSettings chooseNewest(
    AppSettings? localSettings,
    AppSettings? backendSettings,
  ) {
    if (localSettings == null && backendSettings == null) {
      return AppSettings(updatedAt: DateTime.utc(1970));
    }

    if (backendSettings == null) {
      return localSettings!;
    }

    if (localSettings == null) {
      return backendSettings;
    }

    return localSettings.updatedAt.isAfter(backendSettings.updatedAt)
        ? localSettings
        : backendSettings;
  }
}
