import 'package:spender_tracker/features/bottom_navbar/domain/entity/navigation_entity.dart';

abstract class NavigationRepository{
  List<NavigationEntity> getNavigationItems();
}