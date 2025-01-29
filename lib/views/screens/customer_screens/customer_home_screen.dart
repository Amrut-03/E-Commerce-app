import 'package:e_commerce_frontend/controllers/auth_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.decodeToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          final userData = authController.userInfo;
          if (userData.isEmpty) {
            return const Text("Invalid or Expired Token");
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Name: ${userData['firstName'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 18)),
              Text("Email: ${userData['email'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 18)),
              Text("Password: ${userData['password'] ?? 'N/A'}",
                  style: const TextStyle(fontSize: 18)),
              TextButton(
                  onPressed: () async {
                    authController.logout();
                  },
                  child: const Text("Sign-out"))
            ],
          );
        }),
      ),
    );
  }
}
