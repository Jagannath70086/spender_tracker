import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spender_tracker/core/theme/app_colors.dart';
import 'package:spender_tracker/core/ui/widgets/default_button.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_event.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_state.dart';

import '../bloc/user_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const String route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final isDarkMode = state.themeEntity?.themeType == ThemeType.dark;

            return BlocConsumer<UserBloc, UserState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Spendzy",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        'assets/images/login.svg',
                        width: 250,
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Track your spends all in one place',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const Spacer(flex: 2),
                      DefaultButton(
                        text: 'Login with Google',
                        textColor: isDarkMode
                            ? AppColors.textColorDark
                            : AppColors.textColorLight,
                        backgroundColor: isDarkMode
                            ? AppColors.secondaryDark
                            : AppColors.secondaryLight,
                        onPressed: () {
                          context.read<UserBloc>().add(LoginWithGoogleEvent());
                        },
                      ),
                    ],
                  ),
                );
              },
              listener: (context, state) {
                if (state.status == UserStatus.error) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage ?? '')));
                }
              },
            );
          },
        ),
      ),
    );
  }
}