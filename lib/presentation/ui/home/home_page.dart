import 'package:bahaso_mobile_app/presentation/blocs/blocs.dart';
import 'package:bahaso_mobile_app/presentation/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            BasicButton.primary(
              width: double.infinity,
              text: 'Logout',
              onPressed: () => context.read<AuthBloc>().add(AuthLogoutEvent()),
            ),
          ],
        ),
      ),
    );
  }
}
