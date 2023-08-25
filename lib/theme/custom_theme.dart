// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTheme extends ThemeExtension<CustomTheme> {
  final Color seedColor;
  final Color background;
  final Brightness brightness;
  final Color onSecondary;
  final Color onBackground;
  final Color primary;

  CustomTheme({
    required this.seedColor,
    required this.background,
    required this.brightness,
    required this.onSecondary,
    required this.onBackground,
    required this.primary,
  });

  @override
  ThemeExtension<CustomTheme> copyWith(
      {Color? seedColor,
      Color? background,
      Brightness? brightness,
      Color? onSecondary,
      Color? onBackground,
      Color? primary}) {
    return CustomTheme(
        seedColor: seedColor ?? this.seedColor,
        background: background ?? this.background,
        brightness: brightness ?? this.brightness,
        onSecondary: onSecondary ?? this.onSecondary,
        onBackground: onBackground ?? this.onBackground,
        primary: primary ?? this.primary);
  }

  @override
  ThemeExtension<CustomTheme> lerp(
      covariant ThemeExtension<CustomTheme>? other, double t) {
    if (other is! CustomTheme) {
      return this;
    }
    return CustomTheme(
        seedColor: Color.lerp(seedColor, other.seedColor, t)!,
        background: Color.lerp(background, other.background, t)!,
        onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
        onBackground: Color.lerp(onBackground, other.onBackground, t)!,
        primary: Color.lerp(primary, other.primary, t)!,
        brightness: other.brightness);
  }

  static final lightTheme = CustomTheme(
      seedColor: Colors.white,
      background: Colors.white54,
      brightness: Brightness.light,
      onSecondary: Colors.black54,
      onBackground: Colors.grey[400]!,
      primary: Colors.white70);

  static final darkTheme = CustomTheme(
      seedColor: Colors.black,
      background: Colors.black,
      brightness: Brightness.dark,
      onSecondary: Colors.white,
      onBackground: Colors.grey[800]!,
      primary: Colors.black87);
}
