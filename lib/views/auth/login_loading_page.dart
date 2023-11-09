import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginLoadingPage extends ConsumerWidget {
  const LoginLoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: USpace.space20),
              Text('Loading...'),
            ],
          ),
        );
      }),
    );
  }
}
