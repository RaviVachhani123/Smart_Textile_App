import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/routes/app_routes.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  final regNameController = TextEditingController();
  final regEmailController = TextEditingController();
  final regPhoneController = TextEditingController();
  final regPasswordController = TextEditingController();
  final regConfirmPasswordController = TextEditingController();

  final isBuyer = true.obs;
  final termsAccepted = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    regNameController.dispose();
    regEmailController.dispose();
    regPhoneController.dispose();
    regPasswordController.dispose();
    regConfirmPasswordController.dispose();
    super.onClose();
  }

  // --- Validation Logic ---

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != regPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // --- Actions ---

  void login() {
    if (loginFormKey.currentState!.validate()) {
      // Dummy authentication
      Get.snackbar('Success', 'Logged in successfully!', snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(AppRoutes.roleSelection);
    }
  }

  void register() {
    if (registerFormKey.currentState!.validate()) {
      if (!termsAccepted.value) {
        Get.snackbar('Error', 'Please accept the terms and conditions', snackPosition: SnackPosition.BOTTOM);
        return;
      }
      // Dummy registration
      Get.snackbar('Success', 'Account created successfully!', snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(AppRoutes.roleSelection);
    }
  }

  void selectRole(bool buyer) {
    isBuyer.value = buyer;
    if (buyer) {
      Get.offAllNamed(AppRoutes.buyerHome);
    } else {
      Get.offAllNamed(AppRoutes.sellerDashboard);
    }
  }
}
