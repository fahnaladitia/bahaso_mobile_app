import 'package:flutter/material.dart';

import '../../components/components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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
      body: SingleChildScrollView(
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Do login
                    }
                  },
                ),
                const SizedBox(height: 16),
                BasicButton.secondary(
                  width: double.infinity,
                  text: 'Register',
                  onPressed: () {
                    // Navigate to register page
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
