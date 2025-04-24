import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/domain/repository/theme_repository.dart';

class SaveThemeUseCase{
  final ThemeRepository themeRepository;

  SaveThemeUseCase({required this.themeRepository});

  Future call(ThemeEntity themeEntity) async{
    await themeRepository.saveTheme(themeEntity);
  }
}