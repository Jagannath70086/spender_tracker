import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/repository/navigation_repository.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_event.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final NavigationRepository repository;

  NavigationBloc({required this.repository})
      : super(NavigationLoaded(
      items: repository.getNavigationItems(),
      selectedItemId: 'dashboard')) {
    on<NavigationItemSelected>(_onNavigationItemSelected);
  }

  void _onNavigationItemSelected(
      NavigationItemSelected event, Emitter<NavigationState> emit) {
    if (state is NavigationLoaded) {
      final currentState = state as NavigationLoaded;
      emit(NavigationLoaded(
        items: currentState.items,
        selectedItemId: event.itemId,
      ));
    }
  }
}