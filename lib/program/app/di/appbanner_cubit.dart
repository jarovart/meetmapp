import 'dart:async';

import 'package:casttime/program/app/di/appbanner_state.dart';
import 'package:casttime/program/core/failure/appfailure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppBannerCubit extends Cubit<AppBannerState> {
  AppBannerCubit() : super(AppBannerState.initial());

  Timer? _dismissTimer;

  void showFailure(
    AppFailure failure, {
    Duration duration = const Duration(seconds: 5),
  }) {
    _dismissTimer?.cancel();

    emit(
      AppBannerState(
        failure: failure,
        type: AppBannerType.error,
        messageId: state.messageId + 1,
      ),
    );

    _dismissTimer = Timer(duration, dismiss);
  }

  void dismiss() {
    _dismissTimer?.cancel();

    if (!state.isVisible) {
      return;
    }

    emit(state.copyWith(clearFailure: true));
  }

  @override
  Future<void> close() {
    _dismissTimer?.cancel();
    return super.close();
  }
}
