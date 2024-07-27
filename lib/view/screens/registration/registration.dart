import 'package:assignment/model/user_model.dart';
import 'package:assignment/view/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../widgets/button.dart';
import '../../widgets/input.dart';

class RegistrationScreen extends StatelessWidget {
  static String route = '/registration';
  RegistrationScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  AuthController _authController = Get.put(AuthController());

  void _registration() async {
    if (_formKey.currentState!.validate()) {
      UserModel user = UserModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        city: _cityController.text.trim(),
      );
      await _authController.registration(user: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'MyApp',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      textField(
                          controller: _nameController,
                          errorMessage: 'Please enter your name',
                          label: 'Name'),
                      const SizedBox(height: 24),
                      textField(
                          controller: _emailController,
                          errorMessage: 'Please enter your email',
                          label: 'email'),
                      const SizedBox(height: 24),
                      textField(
                          controller: _cityController,
                          errorMessage: 'Please enter your city',
                          label: 'City'),
                    ],
                  )),
              const SizedBox(height: 32),

              // Login Button
              Obx(
                () => button(
                    fn: _registration,
                    isLoading: _authController.isLoading.value,
                    name: 'Registration'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navigate to registration screen
                      Get.toNamed(LoginScreen.route);
                    },
                    child: const Text('Login Here'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
