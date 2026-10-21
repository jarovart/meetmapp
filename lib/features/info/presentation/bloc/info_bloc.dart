import 'package:casttime/app/presentation/util/load_status.dart';
import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/features/info/domain/model/app_status.dart';
import 'package:casttime/features/info/domain/service/info_service.dart';
import 'package:casttime/features/info/presentation/bloc/info_event.dart';
import 'package:casttime/features/info/presentation/bloc/info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc(this._infoService) : super(const InfoState()) {
    on<InfoRequested>(_onRequested);
  }

  final InfoService _infoService;

  Future<void> _onRequested(
    InfoRequested event,
    Emitter<InfoState> emit,
  ) async {
    emit(state.copyWith(status: LoadStatus.loading));

    final result = await _infoService.fetchStatus();
    switch (result) {
      case Success<AppStatus>(:final data):
        emit(
          state.copyWith(
            status: LoadStatus.success,
            appStatus: data,
            failure: null,
          ),
        );
      case Failure<AppStatus>(:final failure):
        emit(state.copyWith(status: LoadStatus.failure, failure: failure));
    }
  }
}
