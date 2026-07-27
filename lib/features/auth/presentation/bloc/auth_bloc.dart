import 'package:casttime/features/auth/domain/service/auth_service.dart';
import 'package:casttime/features/auth/presentation/bloc/auth_event.dart';
import 'package:casttime/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthState.initial()) {
    on<AuthStatusRequested>(_onStatusRequested);
  }

  Future<void> _onStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {}
}
