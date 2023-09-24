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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(USpace.space24),
              decoration: BoxDecoration(
                color: UColors.gray50,
                border: Border.all(
                  color: UColors.blue200,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(USpace.space12),
              ),
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        'assets/logo/logo_color.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: USpace.space20),
                    Text(
                      'U -Traffic Admin',
                      style: const UTextStyle().text3xlfontbold.copyWith(
                            color: UColors.gray700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: USpace.space28),
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
          ],
        ),
      ),
    );
  }
}
