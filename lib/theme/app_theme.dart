import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: ThemeColors.bluePrimary,
      scaffoldBackgroundColor: ThemeColors.white,
      colorScheme: const ColorScheme.light(
        primary: ThemeColors.bluePrimary,
        secondary: ThemeColors.blue10,
        surface: ThemeColors.white,
        onPrimary: ThemeColors.white,
        onSecondary: ThemeColors.black,
        onSurface: ThemeColors.black,
      ),
      // Text theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: ThemeColors.black),
        bodyMedium: TextStyle(color: ThemeColors.black),
        bodySmall: TextStyle(color: ThemeColors.gray20),
      ),
    );
  }
}
