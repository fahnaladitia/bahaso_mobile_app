import 'package:bahaso_mobile_app/di.dart';
import 'package:bahaso_mobile_app/presentation/components/components.dart';
import 'package:bahaso_mobile_app/presentation/ui/register/bloc/register_bloc.dart';
import 'package:bahaso_mobile_app/presentation/utils/toaster_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _registerBloc = getIt.get();
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
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pop(context, true);
          }
          if (state is RegisterError) {
            context.showToastError(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoading;
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
                      'Register',
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
                      text: 'Register',
                      onPressed: isLoading ? null : () => _registerAction(),
                    ),
                    const SizedBox(height: 16),
                    BasicButton.secondary(
                      width: double.infinity,
                      text: 'Back to Login',
                      onPressed: isLoading ? null : () => Navigator.pop(context),
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

  void _registerAction() {
    if (formKey.currentState!.validate()) {
      _registerBloc.add(RegisterSubmittedEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}
