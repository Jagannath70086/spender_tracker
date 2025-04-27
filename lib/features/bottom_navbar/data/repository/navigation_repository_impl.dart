import 'package:flutter/material.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/entity/navigation_entity.dart';
import 'package:spender_tracker/features/bottom_navbar/domain/repository/navigation_repository.dart';

class NavigationRepositoryImpl implements NavigationRepository{
  @override
  List<NavigationEntity> getNavigationItems() {
    return [
      NavigationEntity(
        id: 'dashboard',
        label: 'Dashboard',
        icon: Icons.dashboard,
      ),
      NavigationEntity(
        id: 'cards',
        label: 'Cards',
        icon: Icons.credit_card,
      ),
      NavigationEntity(
        id: 'banks',
        label: 'Banks',
        icon: Icons.account_balance,
      ),
      NavigationEntity(
        id: 'profile',
        label: 'Profile',
        icon: Icons.person
      ),
    ];
  }

}