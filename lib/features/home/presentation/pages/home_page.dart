import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/theme/app_text_styles.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_state.dart';
import 'package:spender_tracker/features/banks/presentation/pages/banks_screen.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_state.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/widgets/navbar.dart';
import 'package:spender_tracker/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:spender_tracker/features/cards/presentation/pages/cards_screen.dart';
import 'package:spender_tracker/features/profile/presentation/pages/profile_screen.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/home';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final items = state.items ?? [];

        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text('Home'), scrolledUnderElevation: 0),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: _getTitleAppbar(state.selectedItemId),
            actions: [
              IconButton(
                onPressed:
                    () => context.read<ThemeBloc>().add(ToggleThemeEvent()),
                icon: Icon(Icons.add),
              ),
            ],
          ),
          body: _getScreenForNavItem(state.selectedItemId),
          bottomNavigationBar: const CustomFloatingNavBar(),
        );
      },
    );
  }

  Widget _getScreenForNavItem(String itemId) {
    switch (itemId) {
      case 'dashboard':
        return DashboardScreen();
      case 'cards':
        return CardsScreen();
      case 'banks':
        return BanksScreen();
      case 'profile':
        return ProfileScreen();
      default:
        return DashboardScreen();
    }
  }

  Widget _getTitleAppbar(String itemId) {
    switch (itemId) {
      case 'dashboard':
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            return Text(
              'Hi ${userState.userModel?.name.split(' ').first},',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        );
      case 'cards':
        return Text('My Cards', style: AppTextStyles.headlineMedium);
      case 'banks':
        return Text('My Banks', style: AppTextStyles.headlineMedium);
      case 'profile':
        return Text('My Account', style: AppTextStyles.headlineMedium);
      default:
        return Text('Dashboard', style: AppTextStyles.headlineMedium);
    }
  }
}
