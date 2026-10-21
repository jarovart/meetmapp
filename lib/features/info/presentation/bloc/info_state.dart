// features/info/presentation/bloc/info_state.dart
import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:casttime/features/info/domain/model/app_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_state.freezed.dart';

@freezed
abstract class InfoState with _$InfoState {
  const factory InfoState({
    @Default(LoadStatus.initial) LoadStatus status,
    AppStatus? appStatus,
    AppFailure? failure,
  }) = _InfoState;
}
