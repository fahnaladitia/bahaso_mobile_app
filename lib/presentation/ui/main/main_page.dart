import 'package:flutter/material.dart';

import '../home/home_page.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
