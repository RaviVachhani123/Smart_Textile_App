import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: controller.registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Join Smart Textile Market',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in your details to get started.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: controller.regNameController,
                      hintText: 'Full Name',
                      prefixIcon: Icons.person_outline,
                      validator: (val) => controller.validateEmpty(val, 'Full Name'),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.regEmailController,
                      hintText: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.regPhoneController,
                      hintText: 'Phone Number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (val) => controller.validateEmpty(val, 'Phone Number'),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.regPasswordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: controller.validatePassword,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.regConfirmPasswordController,
                      hintText: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: controller.validateConfirmPassword,
                    ),
                    const SizedBox(height: 24),
                    Obx(() => Row(
                      children: [
                        Checkbox(
                          value: controller.termsAccepted.value,
                          onChanged: (val) => controller.termsAccepted.value = val ?? false,
                        ),
                        const Expanded(
                          child: Text('I agree to the Terms and Conditions'),
                        ),
                      ],
                    )),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Register',
                      onPressed: controller.register,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
