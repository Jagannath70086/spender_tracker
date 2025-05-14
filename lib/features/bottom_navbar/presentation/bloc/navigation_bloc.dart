import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/repository/navigation_repository.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_event.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final NavigationRepository repository;

  NavigationBloc({required this.repository})
      : super(NavigationState.initial()) {
    on<GetNavigationItemsEvent>(_onGetNavigationItemsEvent);
    on<NavigationItemSelectedEvent>(_onNavigationItemSelectedEvent);
  }

  void _onNavigationItemSelectedEvent(
      NavigationItemSelectedEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(selectedItemId: event.itemId));
  }

  void _onGetNavigationItemsEvent(GetNavigationItemsEvent event, Emitter<NavigationState> emit){
  emit(state.copyWith(items: repository.getNavigationItems()));
}
}