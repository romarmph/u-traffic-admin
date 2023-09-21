import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormController = ref.read(loginFormControllerProvider);

    final emailController = loginFormController.emailController;
    final passwordController = loginFormController.passwordController;
    final isHidden = ref.watch(passwordVisibilityStateProvider);
    final emailError = ref.watch(emailErrorStateProvider);
    final passwordError = ref.watch(passwordErrorStateProvider);

    final showEmailError = emailError != null;
    final showPasswordError = passwordError != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: showEmailError ? UColors.red400 : Colors.white,
              ),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(
              color: showEmailError ? UColors.red400 : UColors.gray400,
            ),
            prefixIcon: const Icon(
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
        Visibility(
          visible: showEmailError,
          child: Text(
            emailError ?? "",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: UColors.red400,
            ),
          ),
        ),
        const SizedBox(height: USpace.space12),
        TextFormField(
          controller: passwordController,
          obscureText: isHidden,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: showPasswordError ? UColors.red400 : Colors.white,
              ),
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: showPasswordError ? UColors.red400 : UColors.gray400,
            ),
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
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: isHidden ? UColors.gray400 : UColors.blue400,
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
        Visibility(
          visible: showPasswordError,
          child: Text(
            passwordError ?? "",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: UColors.red400,
            ),
          ),
        ),
      ],
    );
  }
}
