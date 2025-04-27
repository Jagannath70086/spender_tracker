import 'package:equatable/equatable.dart';

class NavigationEvent extends Equatable{
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigationItemSelected extends NavigationEvent {
  final String itemId;

  const NavigationItemSelected(this.itemId);

  @override
  List<Object> get props => [itemId];
}