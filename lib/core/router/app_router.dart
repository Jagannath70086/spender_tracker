import 'package:go_router/go_router.dart';
import 'package:spender_tracker/features/auth/presentation/pages/auth_page.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: AuthPage.route,
    routes: [
      GoRoute(
        path: AuthPage.route,
        builder: (context, state) {
          return const AuthPage();
        },
      ),
    ],
  );
}
