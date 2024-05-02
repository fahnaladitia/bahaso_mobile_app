import 'package:bahaso_mobile_app/di.dart';
import 'package:bahaso_mobile_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:bahaso_mobile_app/presentation/utils/toaster_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';
import '../register/register_page.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginBloc = getIt.get();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginError) {
            context.showToastError(state.message);
          }
          if (state is LoginSuccess) {
            context.read<AuthBloc>().add(AuthCheckEvent());
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    BasicTextInput(
                      controller: _emailController,
                      hintText: 'Email',
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      readOnly: isLoading,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    BasicTextInput(
                      controller: _passwordController,
                      hintText: 'Password',
                      labelText: 'Password',
                      readOnly: isLoading,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    BasicButton.primary(
                      width: double.infinity,
                      text: 'Login',
                      onPressed: isLoading ? null : () => _loginAction(),
                    ),
                    const SizedBox(height: 16),
                    BasicButton.secondary(
                      width: double.infinity,
                      text: 'Register',
                      onPressed: isLoading
                          ? null
                          : () async {
                              _emailController.clear();
                              _passwordController.clear();
                              final result = await Navigator.pushNamed(context, RegisterPage.routeName);
                              if (!context.mounted) return;
                              if (result == true) {
                                context.showToastSuccess('Register success');
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _loginAction() {
    if (formKey.currentState!.validate()) {
      _loginBloc.add(LoginSubmittedEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}
