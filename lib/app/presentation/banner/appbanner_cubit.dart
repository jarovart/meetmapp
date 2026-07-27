import 'dart:async';

import 'package:casttime/app/presentation/banner/appbanner_state.dart';
import 'package:casttime/core/failure/app_failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppBannerCubit extends Cubit<AppBannerState> {
  AppBannerCubit() : super(AppBannerState.initial()) {
    if (false) {
      _timer = Timer.periodic(
        const Duration(seconds: 10),
        (_) => showFailure(NoConnectionFailure()),
      );
    }
  }

  Timer? _timer;
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
    _timer?.cancel();
    _dismissTimer?.cancel();
    return super.close();
  }
}
