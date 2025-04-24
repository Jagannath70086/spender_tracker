import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Spendzy', style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}
