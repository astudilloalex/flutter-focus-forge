import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/app/states/app_state.dart';
import 'package:focus_forge/src/auth/application/auth_service.dart';
import 'package:focus_forge/src/user/application/user_service.dart';
import 'package:focus_forge/src/user/domain/user.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required this.userService,
    required this.authService,
  }) : super(
          AppState(
            darkTheme: ThemeData.dark(),
            lightTheme: ThemeData.light(),
          ),
        );

  final UserService userService;
  final AuthService authService;

  Future<void> load() async {
    User? user;
    try {
      user = await authService.currentUser;
    } finally {
      emit(
        state.copyWith(
          darkTheme: _darkTheme,
          lightTheme: _lightTheme,
          user: user,
        ),
      );
    }
  }

  ThemeData get _darkTheme {
    return ThemeData.dark().copyWith();
  }

  ThemeData get _lightTheme {
    return ThemeData.light().copyWith(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  void setUser(User user) {
    emit(state.copyWith(user: user));
  }
}
