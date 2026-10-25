import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/storage/preferences_repository.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';
import 'package:casttime/features/setting/domain/repository/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppSettingsCubit extends Cubit<AppSettings> {
  AppSettingsCubit(
    this._authCubit,
    this._settingsService,
    this._preferencesRepository,
  ) : super(AppSettings(updatedAt: DateTime.utc(1970)));

  final AuthCubit _authCubit;
  final SettingsRepository _settingsService;
  final PreferencesRepository _preferencesRepository;

  /// Vor runApp aufrufen, damit die App nie kurz im falschen Design startet.
  Future<void> loadLocal() async {
    AppSettings? local = await _preferencesRepository.readLocalSettings();
    if (local == null) {
      local = state;
      await _preferencesRepository.saveLocalSettings(local);
    } else {
      emit(local);
    }
  }

  /// Nach Login oder erfolgreichem Speichern.
  Future<void> apply(AppSettings settings) async {
    emit(settings);
    await _preferencesRepository.saveLocalSettings(settings);
  }

  Future<void> syncFromServer() async {
    if (!_authCubit.isAuthenticated()) {
      debugPrint("Not authenticated, skipping sync from server.");
      return;
    }
    final result = await _settingsService.loadRemote();
    if (result case Success<AppSettings>(:final data)) {
      await apply(data);
    }
  }
}
