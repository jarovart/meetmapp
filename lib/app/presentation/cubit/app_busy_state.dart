import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_busy_state.freezed.dart';

@freezed
abstract class AppBusyState with _$AppBusyState {
  const factory AppBusyState({
    @Default(false) bool isBusy,
    String? messageKey,
  }) = _AppBusyState;
}
