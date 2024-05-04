import 'package:bahaso_mobile_app/di.dart';
import 'package:bahaso_mobile_app/presentation/blocs/blocs.dart';
import 'package:bahaso_mobile_app/presentation/ui/home/home_page.dart';
import 'package:bahaso_mobile_app/presentation/ui/login/login_page.dart';
import 'package:bahaso_mobile_app/presentation/utils/toaster_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/';
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt.get();
    _authBloc.add(AuthCheckEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError || state is AuthUnauthenticated || state is AuthAuthenticated) {
            FlutterNativeSplash.remove();
          }
          if (state is AuthError) {
            context.showToastError(state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is AuthAuthenticated) {
            return const HomePage();
          }

          if (state is AuthUnauthenticated) {
            return const LoginPage();
          }

          return const Scaffold(body: SizedBox.shrink());
        },
      ),
    );
  }
}
