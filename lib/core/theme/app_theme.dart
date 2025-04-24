import 'package:flutter/material.dart';
import 'package:spender_tracker/core/theme/app_colors.dart';
import 'package:spender_tracker/core/theme/app_text_styles.dart';

class AppTheme {
  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: TextTheme(
        bodySmall: AppTextStyles.bodySmall,
        bodyMedium: AppTextStyles.bodyMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        headlineSmall: AppTextStyles.headlineSmall,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineLarge: AppTextStyles.headlineLarge,
      ),
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: isDark ? AppColors.primaryDark : AppColors.primaryLight,
        onPrimary:
            isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        secondary: isDark ? AppColors.secondaryDark : AppColors.secondaryLight,
        onSecondary:
            isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        error: isDark ? AppColors.errorColorDark : AppColors.errorColorLight,
        onError: isDark ? AppColors.secondaryDark : AppColors.surfaceLight,
        surface: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        onSurface: isDark ? AppColors.textColorDark : AppColors.textColorLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? AppColors.primaryDark : AppColors.primaryLight,
          foregroundColor:
              isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          elevation: 0,
          disabledBackgroundColor: (isDark
                  ? AppColors.primaryDark
                  : AppColors.primaryLight)
              .withValues(alpha: 0.3),
          textStyle: AppTextStyles.button,
        ),
      ),
    );
  }
}
