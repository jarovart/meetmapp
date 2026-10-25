import 'package:casttime/core/result/app_result.dart';
import 'package:casttime/core/storage/token_storage.dart';
import 'package:casttime/features/auth/domain/model/auth_session.dart';
import 'package:casttime/features/auth/domain/model/auth_tokens.dart';
import 'package:casttime/features/auth/domain/repository/auth_repository.dart';
import 'package:casttime/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository, this._tokenStorage)
    : super(const AuthState());

  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  Future<void> checkAuthStatus() async {
    final session = await _tokenStorage.readSession();
    if (session == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      return;
    }
    emit(
      state.copyWith(
        status: AuthStatus.authenticated,
        userId: session.userId,
        username: session.username,
        myProfileUrl: session.myProfileUrl,
      ),
    );
  }

  Future<AppResult<void>> login({
    required String username,
    required String password,
  }) async {
    final result = await _authRepository.login(username, password);
    switch (result) {
      case Success<AuthSession>(:final data):
        await _tokenStorage.saveSession(data);
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            userId: data.userId,
            username: data.username,
            myProfileUrl: data.myProfileUrl,
          ),
        );
        return const Success(null);
      case Failure<AuthSession>(:final failure):
        return Failure(failure);
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    await _tokenStorage.clearSession();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  Future<bool> refreshTokenIfNeeded() async {
    final session = await _tokenStorage.readSession();
    if (session == null) return false;

    final result = await _authRepository.refreshToken(
      session.tokens.refreshToken,
    );
    switch (result) {
      case Success<AuthTokens>(:final data):
        await _tokenStorage.saveSession(session.copyWith(tokens: data));
        return true;
      case Failure<AuthTokens>():
        await logout();
        return false;
    }
  }

  bool isAuthenticated() {
    return state.isLoggedIn;
  }
}
