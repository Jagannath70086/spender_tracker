import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/core/di/get_it.dart';
import 'package:spender_tracker/core/router/app_router.dart';
import 'package:spender_tracker/core/theme/app_theme.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(
    BlocProvider(
      create: (context) => getIt<UserBloc>(),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
