import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme>
{
  // reference colors:
  static const _grey = Color(0xFFB0B0B0);
  static const _green = Color(0xFF00C060);
  static const _red = Color(0xFFED4E52);
  static const _black = Colors.black;

  // actual colors used throughout the app:
  final Color backgroundDefault;
  final Color backgroundInput;
  final Color snackbarValidation;  
  final Color snackbarError;
  final Color textDefault;
  final Color backgroundActionPrimary;
  final Color backgroundActionPrimaryDisabled;

  // private constructor (use factories below instead):
  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.backgroundInput,
    required this.snackbarValidation,
    required this.snackbarError,
    required this.textDefault,
    required this.backgroundActionPrimary,
    required this.backgroundActionPrimaryDisabled,
  });

  // factory for light mode:
  factory AppColorsTheme.light() {
    return AppColorsTheme._internal(
      backgroundDefault: _grey,
      backgroundInput: _grey,
      snackbarValidation: _green,
      snackbarError: _red,
      textDefault: _grey,
      backgroundActionPrimary: _green,
      backgroundActionPrimaryDisabled: _black,
    );  
  }
/*
  // factory for dark mode:
  factory AppColorsTheme.dark() {
    return AppColorsTheme._internal(...);
  }*/
  
  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode})
  {
    // if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    // }
    // return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    covariant ThemeExtension<AppColorsTheme>? other,
    double t) => this;
}