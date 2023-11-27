import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class LoginErrorPage extends ConsumerWidget {
  const LoginErrorPage({
    super.key,
    this.title,
    this.message,
  });

  final String? title;
  final String? message;

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
              Visibility(
                visible: !(title != null),
                child: Column(
                  children: [
                    const Text('An error occured. Please try again later.'),
                    const SizedBox(height: USpace.space20),
                    ElevatedButton(
                      onPressed: () {
                        ref.watch(authServiceProvider).logout();
                      },
                      child: const Text('Go back to login'),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: title != null,
                child: Column(
                  children: [
                    Text(
                      title!,
                      style: const UTextStyle().text2xlfontmedium,
                    ),
                    const SizedBox(height: USpace.space12),
                    Text(
                      message!,
                      style: const UTextStyle().textlgfontmedium,
                    ),
                    const SizedBox(height: USpace.space20),
                    ElevatedButton(
                      onPressed: () {
                        ref.watch(authServiceProvider).logout();
                      },
                      child: const Text('Go back to login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
