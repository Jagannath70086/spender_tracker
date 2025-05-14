import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/di/get_it.dart';
import 'package:spender_tracker/core/router/app_router.dart';
import 'package:spender_tracker/core/theme/app_theme.dart';
import 'package:spender_tracker/core/ui/widgets/update_dialog.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_state.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_bloc.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_event.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_event.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_bloc.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_event.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:spender_tracker/features/home/presentation/pages/home_page.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_event.dart';
import 'package:spender_tracker/features/auth/presentation/pages/auth_page.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_event.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_state.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_state.dart';
import 'package:spender_tracker/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setup();
  runApp(const SpenderTrackerApp());
}

class SpenderTrackerApp extends StatelessWidget {
  const SpenderTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(
          create: (context) => getIt<ThemeBloc>()..add(GetThemeEvent()),
        ),
        BlocProvider(create: (context) => getIt<NavigationBloc>()..add(GetNavigationItemsEvent())),
        BlocProvider(create: (context) => getIt<DashboardBloc>()),
        BlocProvider(
          create: (context) => getIt<AppInfoBloc>()..add(FetchAppInfo()),
        ),
        BlocProvider(create: (context) => getIt<ProfileBloc>()),
        BlocProvider(create: (context) => getIt<CardBloc>()),
        BlocProvider(create: (context) => getIt<BankBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            theme: AppTheme.getTheme(false),
            darkTheme: AppTheme.getTheme(true),
            themeMode: state.themeEntity?.themeMode ?? ThemeMode.system,
            builder:
                (context, router) => _buildAppWithListeners(context, router),
          );
        },
      ),
    );
  }

  Widget _buildAppWithListeners(BuildContext context, Widget? router) {
    return BlocListener<AppInfoBloc, AppInfoState>(
      listenWhen: (prev, curr) => curr.appInfoModel != null && curr != prev,
      listener: (context, appInfoState) {
        final appModel = appInfoState.appInfoModel;
        final needsForceUpdate = _shouldForceUpdate(appModel);

        if (!needsForceUpdate) {
          context.read<UserBloc>().add(GetUserEvent());
        }
      },
      child: BlocBuilder<AppInfoBloc, AppInfoState>(
        builder: (context, appInfoState) {
          final appModel = appInfoState.appInfoModel;

          if (_shouldForceUpdate(appModel)) {
            return UpdateRequiredDialog(appModel: appModel!);
          }

          return BlocListener<UserBloc, UserState>(
            listener: _handleAuthStateChanges,
            child: router ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  bool _shouldForceUpdate(dynamic appModel) {
    return appModel != null &&
        (appModel.forceUpdate ?? false) &&
        appModel.currentVersion != appModel.latestVersion;
  }

  void _handleAuthStateChanges(BuildContext context, UserState state) {
    if (state.status == UserStatus.success) {
      context.read<CardBloc>().add(LoadCardEvent());
      context.read<BankBloc>().add(LoadBankEvent());
      AppRouter.router.go(HomePage.route);
    } else if (state.status == UserStatus.error ||
        state.status == UserStatus.logout) {
      AppRouter.router.go(AuthPage.route);
    }
  }
}
