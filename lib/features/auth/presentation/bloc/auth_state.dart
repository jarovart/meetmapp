class AuthState {
  final bool isLoading;
  final bool isLoggedIn;

  const AuthState({required this.isLoading, this.isLoggedIn = false});

  factory AuthState.initial() {
    return const AuthState(isLoading: false);
  }
}
