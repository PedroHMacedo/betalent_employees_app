import 'package:betalent_employees_app/theme/text_styles.dart';
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
        outline: ThemeColors.gray10,
        surfaceContainerHighest: ThemeColors.gray00,
        inverseSurface: ThemeColors.gray20,
        surfaceTint: ThemeColors.gray05,
      ),

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        displaySmall: AppTextStyles.h3,
      ),
    );
  }
}
