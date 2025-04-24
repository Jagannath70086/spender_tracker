import 'package:shared_preferences/shared_preferences.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';

class ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDataSource({required this.sharedPreferences});

  Future saveTheme(ThemeEntity theme) async{
    var themeValue = theme.themeType == ThemeType.dark ? 'dark' : 'light';
    await sharedPreferences.setString('theme', themeValue);
  }

  Future<ThemeEntity> getTheme() async{
    var themeValue = sharedPreferences.getString('theme');
    return ThemeEntity(themeType: themeValue == 'dark' ? ThemeType.dark : ThemeType.light);
  }
}