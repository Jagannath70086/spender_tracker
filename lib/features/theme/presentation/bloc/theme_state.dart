import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';

enum ThemeStatus { initial, loading, success, error }

class ThemeState {
  final ThemeStatus status;
  final String? errorMessage;
  final ThemeEntity? themeEntity;

  ThemeState._({required this.status, this.errorMessage, this.themeEntity});

  factory ThemeState.initial() => ThemeState._(status: ThemeStatus.initial);

  ThemeState copyWith({
    ThemeStatus? status,
    String? errorMessage,
    ThemeEntity? themeEntity,
  }) => ThemeState._(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    themeEntity: themeEntity ?? this.themeEntity,
  );
}
