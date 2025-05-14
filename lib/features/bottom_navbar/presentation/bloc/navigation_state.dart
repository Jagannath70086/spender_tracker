import 'package:equatable/equatable.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/entity/navigation_entity.dart';

class NavigationState extends Equatable {
  final List<NavigationEntity>? items;
  final String selectedItemId;

  const NavigationState._({this.items, required this.selectedItemId});

  factory NavigationState.initial() => NavigationState._(selectedItemId: 'dashboard');

  NavigationState copyWith({
    List<NavigationEntity>? items,
    String? selectedItemId,
  }) {
    return NavigationState._(
      items: items ?? this.items,
      selectedItemId: selectedItemId ?? this.selectedItemId,
    );
  }

  @override
  List<Object?> get props => [items, selectedItemId];
}