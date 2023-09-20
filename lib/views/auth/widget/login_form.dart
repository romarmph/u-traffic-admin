import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginController =
        ref.watch(loginFormControllerProvider).loginController;
    final passwordController =
        ref.watch(loginFormControllerProvider).passwordController;

    return Column(
      children: [
        TextFormField(
          controller: loginController,
          decoration: const InputDecoration(
            labelText: 'Email',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter your email';
            }

            return null;
          },
        ),
        const SizedBox(height: USpace.space12),
        TextFormField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter your password';
            }

            return null;
          },
        ),
      ],
    );
  }
}
