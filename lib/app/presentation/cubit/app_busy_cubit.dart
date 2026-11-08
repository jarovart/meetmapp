import 'package:casttime/app/presentation/cubit/app_busy_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppBusyCubit extends Cubit<AppBusyState> {
  AppBusyCubit() : super(const AppBusyState());

  final Map<Object, String?> _tokens = {};

  void start(Object token, {String? messageKey}) {
    _tokens[token] = messageKey;
    _emitState();
  }

  void finish(Object token) {
    _tokens.remove(token);
    _emitState();
  }

  void _emitState() {
    emit(
      AppBusyState(
        isBusy: _tokens.isNotEmpty,
        messageKey: _tokens.values.lastWhere(
          (m) => m != null,
          orElse: () => null,
        ),
      ),
    );
  }
}
