import 'package:go_router/go_router.dart';
import 'package:spender_tracker/features/auth/presentation/pages/auth_page.dart';
import 'package:spender_tracker/features/home/presentation/pages/home_page.dart';
import 'package:spender_tracker/features/profile/presentation/pages/update_profile.dart';

import '../../splash_page.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: SplashPage.route,
    routes: [
      GoRoute(
        path: SplashPage.route,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: AuthPage.route,
        builder: (context, state) {
          return const AuthPage();
        },
      ),
      GoRoute(
        path: HomePage.route,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: UpdateProfile.route,
        builder: (context, state) => const UpdateProfile(),
      ),
    ],
  );
}
