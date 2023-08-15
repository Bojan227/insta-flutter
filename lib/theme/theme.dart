import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    background: Colors.white54,
    primary: Colors.white70,
    brightness: Brightness.light,
    onSecondary: Colors.black54,
    onBackground: Colors.grey[400],
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    background: Colors.black,
    onBackground: Colors.grey[800],
    brightness: Brightness.dark,
    primary: Colors.black87,
    secondary: Colors.black45,
    onSecondary: Colors.white,
  ),
);
