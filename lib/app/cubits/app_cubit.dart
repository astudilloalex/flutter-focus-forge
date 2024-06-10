import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_forge/app/states/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit()
      : super(
          AppState(
            darkTheme: ThemeData.dark(),
            lightTheme: ThemeData.light(),
          ),
        );

  Future<void> load() async {
    emit(
      state.copyWith(
        darkTheme: _darkTheme,
        lightTheme: _lightTheme,
      ),
    );
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
}
