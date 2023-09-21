import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.read(emailControllerProvider);
    final passwordController = ref.read(passwordControllerProvider);
    final isVisible = ref.watch(passwordVisibilityStateProvider);

    return Column(
      children: [
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(
              Icons.mail,
              size: USpace.space16,
            ),
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
          obscureText: isVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(
              Icons.lock,
              size: USpace.space16,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                ref.read(passwordVisibilityStateProvider.notifier).update(
                      (state) => !state,
                    );
              },
              icon: Icon(
                isVisible ? Icons.visibility_off : Icons.visibility,
              ),
            ),
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
