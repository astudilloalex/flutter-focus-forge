import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/src/auth/application/auth_service.dart';
import 'package:focus_forge/ui/pages/splash/states/splash_state.dart';
import 'package:focus_forge/ui/routes/route_name.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.authService,
  }) : super(const SplashState());

  final AuthService authService;

  Future<String> get route async {
    try {
      if (await authService.isLoggedIn) {
        return RouteName.home;
      }
      return RouteName.home;
    } on Exception {
      return RouteName.signIn;
    }
  }
}
