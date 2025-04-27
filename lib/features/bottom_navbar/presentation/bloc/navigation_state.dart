import 'package:equatable/equatable.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/entity/navigation_entity.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationLoaded extends NavigationState {
  final List<NavigationEntity> items;
  final String selectedItemId;

  const NavigationLoaded({required this.items, required this.selectedItemId});


  @override
  List<Object> get props => [items, selectedItemId];
}