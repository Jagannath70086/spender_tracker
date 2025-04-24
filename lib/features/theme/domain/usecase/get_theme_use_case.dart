import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/domain/repository/theme_repository.dart';

class GetThemeUseCase{
  final ThemeRepository themeRepository;

  GetThemeUseCase({required this.themeRepository});

  Future<ThemeEntity> call() async{
    return await themeRepository.getTheme();
  }
}