import 'package:bahaso_mobile_app/presentation/ui/login/login_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
