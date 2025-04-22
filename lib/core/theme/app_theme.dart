import 'package:flutter/material.dart';
import 'package:spender_tracker/core/theme/app_colors.dart';
import 'package:spender_tracker/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodySmall: AppTextStyles.bodySmall,
      bodyMedium: AppTextStyles.bodyMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      headlineSmall: AppTextStyles.headlineSmall,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineLarge: AppTextStyles.headlineLarge,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.backgroundLight,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.backgroundLight,
      error: AppColors.errorColorLight,
      onError: AppColors.surfaceLight,
      surface: AppColors.backgroundLight,
      onSurface: AppColors.textColorLight,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.backgroundLight,
        elevation: 0,
        disabledBackgroundColor: AppColors.primaryLight.withValues(alpha: 0.3),
        textStyle: AppTextStyles.button,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodySmall: AppTextStyles.bodySmall,
      bodyMedium: AppTextStyles.bodyMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      headlineSmall: AppTextStyles.headlineSmall,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineLarge: AppTextStyles.headlineLarge,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.backgroundDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.backgroundDark,
      error: AppColors.errorColorDark,
      onError: AppColors.surfaceDark,
      surface: AppColors.backgroundDark,
      onSurface: AppColors.textColorDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.backgroundDark,
        elevation: 0,
        disabledBackgroundColor: AppColors.primaryDark.withValues(alpha: 0.3),
        textStyle: AppTextStyles.button,
      ),
    ),
  );
}
