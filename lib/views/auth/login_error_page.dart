import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginErrorPage extends ConsumerWidget {
  const LoginErrorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error'),
              const SizedBox(height: USpace.space20),
              ElevatedButton(
                onPressed: () {
                  ref.watch(authServiceProvider).logout();
                },
                child: const Text('Go back to login'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
