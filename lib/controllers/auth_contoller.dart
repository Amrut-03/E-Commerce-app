import 'dart:developer';

import 'package:e_commerce_frontend/core/repositories/auth_repositaory.dart';
import 'package:e_commerce_frontend/views/screens/auth_selection_screen.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/auth/signin_screen.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  var isLoading = false.obs;

  Future<void> signin(String email, String password, String userType) async {
    isLoading.value = true;
    log("Sign-In Controller: $userType");
    bool success = await _authRepository.login(email, password, userType);
    isLoading.value = false;

    if (success) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.snackbar("Error", "Invalid email or password");
    }
  }

  Future<void> signup(String firstName, String lastName, String email,
      String password, String userType) async {
    isLoading.value = true;
    log("Sign-Up Controller: $userType");
    bool success = await _authRepository.signup(
        firstName, lastName, email, password, userType);
    isLoading.value = false;

    if (success) {
      Get.offAll(() => SignInScreen(
            userType: userType,
          ));
      log(userType);
    } else {
      Get.snackbar("Error", "Signup failed. Try again.");
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAll(() => const AuthSelectionScreen());
  }

  var userInfo = {}.obs;

  void decodeToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    log(token!);
    if (JwtDecoder.isExpired(token)) {
      log("Token is expired");
      return;
    }
    userInfo.value = JwtDecoder.decode(token);
  }
}
