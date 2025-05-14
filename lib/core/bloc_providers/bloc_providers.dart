import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/di/get_it.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/banks/presentation/bloc/bank_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/cards/presentation/bloc/card_bloc.dart';
import 'package:spender_tracker/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_event.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';

/// Provider class for managing global BloC providers
class AppBlocProviders {
  /// Returns the list of BlocProviders to be used in the app
  static List<BlocProvider> providers() {
    return [
      BlocProvider(create: (context) => getIt<UserBloc>()),
      BlocProvider(
        create: (context) => getIt<ThemeBloc>()..add(GetThemeEvent()),
      ),
      BlocProvider(create: (context) => getIt<NavigationBloc>()),
      BlocProvider(create: (context) => getIt<DashboardBloc>()),
      BlocProvider(
        create: (context) => getIt<AppInfoBloc>()..add(FetchAppInfo()),
      ),
      BlocProvider(create: (context) => getIt<ProfileBloc>()),
      BlocProvider(create: (context) => getIt<CardBloc>()),
      BlocProvider(create: (context) => getIt<BankBloc>()),
    ];
  }
}