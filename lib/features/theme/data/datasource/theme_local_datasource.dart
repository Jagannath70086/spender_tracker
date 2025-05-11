import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';

class ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSource({required this.sharedPreferences});

  Future saveTheme(ThemeEntity theme) async {
    if (theme.themeMode == ThemeMode.dark) {
      await sharedPreferences.setString('theme', 'dark');
    } else if (theme.themeMode == ThemeMode.light) {
      await sharedPreferences.setString('theme', 'light');
    } else {
      await sharedPreferences.setString('theme', 'system');
    }
  }

  Future<ThemeEntity> getTheme() async {
    var themeValue = sharedPreferences.getString('theme');
    return ThemeEntity(
      themeMode:
          themeValue == 'dark'
              ? ThemeMode.dark
              : themeValue == 'light'
              ? ThemeMode.light
              : ThemeMode.system,
    );
  }
}
