import 'package:focus_forge/src/user/domain/user.dart';

class SignInState {
  const SignInState({
    this.loading = false,
    this.user,
  });

  final bool loading;
  final User? user;

  SignInState copyWith({
    bool? loading,
    User? user,
  }) {
    return SignInState(
      loading: loading ?? this.loading,
    );
  }
}
