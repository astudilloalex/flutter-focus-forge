import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/src/auth/application/auth_service.dart';
import 'package:focus_forge/src/common/domain/custom_http_exception.dart';
import 'package:focus_forge/src/user/domain/user.dart';
import 'package:focus_forge/ui/pages/sign_in/states/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.authService,
  }) : super(const SignInState());

  final AuthService authService;

  Future<String?> signInWithGoogle() async {
    User? user;
    try {
      emit(state.copyWith(loading: true));
      user = await authService.signInWithGoogle();
    } on CustomHttpException catch (e) {
      return e.message;
    } on Exception catch (e) {
      return e.toString();
    } finally {
      emit(
        state.copyWith(
          loading: false,
          user: user,
        ),
      );
    }
    return null;
  }

  Future<void> signOut() {
    return authService.signOut();
  }
}
