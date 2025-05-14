import 'package:go_router/go_router.dart';
import 'package:spender_tracker/features/auth/presentation/pages/auth_page.dart';
import 'package:spender_tracker/features/banks/presentation/sub_features/add_bank/presentation/pages/add_bank.dart';
import 'package:spender_tracker/features/cards/presentation/sub_features/add_card/presentation/pages/add_card.dart';
import 'package:spender_tracker/features/home/presentation/pages/home_page.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/pages/about_us.dart';
import 'package:spender_tracker/features/profile/sub_features/contact_us/presentation/pages/contact_us.dart';
import 'package:spender_tracker/features/profile/sub_features/update_profile/presentation/pages/update_profile.dart';

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
      GoRoute(
        path: AboutUsPage.route,
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: HelpSupportPage.route,
        builder: (context, state) => const HelpSupportPage(),
      ),
      GoRoute(
        path: AddCard.route,
        builder: (context, state) => AddCard(),
      ),
      GoRoute(
        path: AddBank.route,
        builder: (context, state) => const AddBank(),
      ),
    ],
  );
}
