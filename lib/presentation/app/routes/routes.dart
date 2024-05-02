import 'package:flutter/material.dart';

import '../../ui/main/main_page.dart';
import '../../ui/register/register_page.dart';

const String initialRoute = MainPage.routeName;

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  try {
    switch (settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => const MainPage());
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
                child: Column(
              children: [
                Text('No route defined for ${settings.name}'),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false),
                  child: const Text('Back to Home Page'),
                ),
              ],
            )),
          ),
        );
    }
  } catch (e) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Error: $e \n\nPlease contact the developer.'),
              ElevatedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, MainPage.routeName, (route) => false),
                child: const Text('Back to Home Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
