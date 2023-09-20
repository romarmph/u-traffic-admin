import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formkey = ref.watch(loginFormControllerProvider).formKey;

    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(USpace.space12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Login',
                style: const UTextStyle().leadingloosetext2xlfontbold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: USpace.space20),
              Form(
                key: formkey,
                child: const LoginForm(),
              ),
              const SizedBox(height: USpace.space20),
              ElevatedButton(
                onPressed: () {
                  ref.watch(loginFormControllerProvider).login();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
