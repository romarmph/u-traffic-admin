import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = ref.read(loginFormControllerProvider).formKey;

    return Scaffold(
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          padding: const EdgeInsets.all(USpace.space12),
          decoration: BoxDecoration(
            color: UColors.gray50,
            border: Border.all(
              color: UColors.blue200,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(USpace.space12),
          ),
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
                key: formKey,
                child: const LoginForm(),
              ),
              const SizedBox(height: USpace.space20),
              const LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
