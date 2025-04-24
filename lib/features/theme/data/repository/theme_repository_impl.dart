import 'package:spender_tracker/features/theme/data/datasource/theme_local_datasource.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository{
  final ThemeLocalDataSource themeLocalDataSource;

  ThemeRepositoryImpl({required this.themeLocalDataSource});
  @override
  Future<ThemeEntity> getTheme() async{
    return await themeLocalDataSource.getTheme();
  }

  @override
  Future saveTheme(ThemeEntity theme) async{
    await themeLocalDataSource.saveTheme(theme);
  }

}