import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/domain/usecase/get_theme_use_case.dart';
import 'package:spender_tracker/features/theme/domain/usecase/save_theme_use_case.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  ThemeBloc({required this.getThemeUseCase, required this.saveThemeUseCase})
    : super(ThemeState.initial()) {
    on<GetThemeEvent>(onGetThemeEvent);
    on<ToggleThemeEvent>(onToggleThemeEvent);
    on<ToggleThemeWithValueEvent>(onToggleThemeWithValueEvent);
  }

  Future onGetThemeEvent(GetThemeEvent event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(status: ThemeStatus.loading));
    try {
      var result = await getThemeUseCase();
      emit(state.copyWith(status: ThemeStatus.success, themeEntity: result));
    } catch (e) {
      emit(
        state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future onToggleThemeEvent(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    if (state.themeEntity != null) {
      var newThemeMode =
          state.themeEntity!.themeMode == ThemeMode.dark
              ? ThemeMode.light
              : ThemeMode.dark;
      var newThemeEntity = ThemeEntity(themeMode: newThemeMode);
      try {
        await saveThemeUseCase(newThemeEntity);
        emit(
          state.copyWith(
            status: ThemeStatus.success,
            themeEntity: newThemeEntity,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()),
        );
      }
    }
  }

  Future onToggleThemeWithValueEvent(
    ToggleThemeWithValueEvent event,
    Emitter<ThemeState> emit,
  ) async {
    var newThemeEntity = ThemeEntity(themeMode: event.themeMode);
    try {
      await saveThemeUseCase(newThemeEntity);
      emit(
        state.copyWith(
          status: ThemeStatus.success,
          themeEntity: newThemeEntity,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ThemeStatus.error, errorMessage: e.toString()),
      );
    }
  }
}
