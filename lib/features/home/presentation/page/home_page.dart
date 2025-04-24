import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/ui/widgets/circle_user_avatar.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_state.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Home Page')],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Cards',
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Row(
            children: [
              CircleUserAvatar(
                width: 30,
                height: 30,
                url: state.userModel?.photoUrl ?? '',
              ),
              SizedBox(width: 15),
              Text(
                state.userModel?.name ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          );
        },
      ),
      actions: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
              icon: Icon(
                state.themeEntity?.themeType == ThemeType.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            );
          },
        ),
      ],
    );
  }
}
