import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/di/get_it.dart';
import 'package:spender_tracker/core/router/app_router.dart';
import 'package:spender_tracker/core/theme/app_theme.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_event.dart';
import 'package:spender_tracker/features/auth/presentation/pages/auth_page.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_state.dart';
import 'package:spender_tracker/firebase_options.dart';

import 'features/auth/presentation/bloc/user_state.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()..add(GetUserEvent())),
        BlocProvider(create: (context) => getIt<ThemeBloc>()..add(GetThemeEvent())),
        BlocProvider(create: (context) => getIt<NavigationBloc>()),
        BlocProvider(create: (context) => getIt<DashboardBloc>()),
      ],
      child: BlocBuilder<ThemeBloc,ThemeState>(
        builder: (context,state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: AppTheme.getTheme(state.themeEntity?.themeType == ThemeType.dark),
            debugShowCheckedModeBanner: false,
            builder: (context, router) {
              return BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.status == UserStatus.success) {
                    AppRouter.router.go(HomePage.route);
                  } else if (state.status == UserStatus.error || state.status == UserStatus.logout) {
                    AppRouter.router.go(AuthPage.route);
                  }
                },
                child: router,
              );
            },
          );
        }
      ),
    ),
  );
}
