import 'package:assignment/controller/auth_controller.dart';
import 'package:assignment/view/screens/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';
import '../../widgets/input.dart';

class LoginScreen extends StatefulWidget {
  static String route = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthController _authController = Get.put(AuthController());

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Perform login action
      await _authController.login(email: _emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Branding or Logo
            const Text(
              'MyApp',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // Login Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email Field
                  textField(
                      controller: _emailController,
                      errorMessage: 'Please enter your email',
                      label: 'email'),

                  const SizedBox(height: 24),

                  // Login Button
                  Obx(
                    () => button(
                        fn: () {
                          _login();
                        },
                        isLoading: _authController.isLoading.value,
                        name: 'Login'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Registration Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    // Navigate to registration screen
                    Get.toNamed(RegistrationScreen.route);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
