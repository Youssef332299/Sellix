class AuthState {

  final bool loading;

  AuthState({this.loading = false});

  AuthState copyWith({bool? loading}) {
    return AuthState(
      loading: loading ?? this.loading,
    );
  }
}
