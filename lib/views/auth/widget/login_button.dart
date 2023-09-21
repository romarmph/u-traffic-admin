import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final isLoadingStateProvider = StateProvider<bool>((ref) {
  return false;
});

final isLoadingProvider =
    Provider<bool>((ref) => ref.watch(isLoadingStateProvider));

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormController = ref.read(loginFormControllerProvider);

    final formKey = loginFormController.formKey;
    final emailController = loginFormController.emailController;
    final passwordController = loginFormController.passwordController;
    final isLoading = ref.watch(isLoadingProvider);

    void setLoading(bool value) {
      ref.read(isLoadingStateProvider.notifier).update((state) => value);
    }

    void login() async {
      if (formKey.currentState!.validate()) {
        try {
          setLoading(true);
          await ref.read(authServiceProvider).login(
                email: emailController.text,
                password: passwordController.text,
              );

          ref.read(emailErrorStateProvider.notifier).update((state) {
            return null;
          });
          ref.read(passwordErrorStateProvider.notifier).update((state) {
            return null;
          });
          loginFormController.clear();
        } on CustomException catch (e) {
          if (e == CustomExceptions.adminNotFound) {
            ref.read(emailErrorStateProvider.notifier).update((state) {
              return e.message;
            });
          } else {
            ref.read(emailErrorStateProvider.notifier).update((state) {
              return null;
            });
          }

          if (e == CustomExceptions.incorrectPassword) {
            ref.read(passwordErrorStateProvider.notifier).update((state) {
              return e.message;
            });
          } else {
            ref.read(passwordErrorStateProvider.notifier).update((state) {
              return null;
            });
          }

          if (e == CustomExceptions.tooManyRequests) {
            CustomAlerts.showError(
              title: 'Login Error',
              text: e.message,
            );
          }
        }

        setLoading(false);
      }
    }

    return ElevatedButton(
      onPressed: login,
      child: isLoading
          ? const CircularProgressIndicator(
              color: UColors.white,
            )
          : const Text('Login'),
    );
  }
}
