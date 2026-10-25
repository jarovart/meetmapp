import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/setting/domain/model/app_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_form_state.freezed.dart';

@freezed
abstract class SettingsFormState with _$SettingsFormState {
  const factory SettingsFormState({
    @Default(LoadStatus.initial) LoadStatus status,
    required AppSettings draft,
    required AppSettings saved,
    @Default(false) bool isSaving,
    AppFailure? failure,
  }) = _SettingsFormState;

  const SettingsFormState._();

  bool get hasChanges => draft != saved;
}
