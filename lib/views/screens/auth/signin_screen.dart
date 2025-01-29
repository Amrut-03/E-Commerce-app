import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_frontend/controllers/auth_contoller.dart';
import 'package:e_commerce_frontend/core/repositories/auth_repositaory.dart';
import 'package:e_commerce_frontend/views/screens/auth/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final userType;

  const SignInScreen({
    super.key,
    this.userType,
  });
  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Obx(() {
              return authController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        authController.signin(emailController.text.trim(),
                            passwordController.text.trim(), widget.userType);
                        // ignore: prefer_interpolation_to_compose_strings
                        log("Sign-In Screen : " + widget.userType);
                      },
                      child: const Text("Sign In"),
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Get.to(() => SignUpScreen(
                      userType: widget.userType,
                    ));
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
