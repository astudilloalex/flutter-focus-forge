import 'package:flutter/material.dart';
import 'package:focus_forge/src/user/domain/user.dart';

class AppState {
  const AppState({
    required this.darkTheme,
    required this.lightTheme,
    this.themeMode = ThemeMode.system,
    this.user,
  });

  final ThemeData darkTheme;
  final ThemeData lightTheme;
  final ThemeMode themeMode;
  final User? user;

  AppState copyWith({
    ThemeData? darkTheme,
    ThemeData? lightTheme,
    ThemeMode? themeMode,
    User? user,
  }) {
    return AppState(
      darkTheme: darkTheme ?? this.darkTheme,
      lightTheme: lightTheme ?? this.lightTheme,
      themeMode: themeMode ?? this.themeMode,
      user: user ?? this.user,
    );
  }
}
