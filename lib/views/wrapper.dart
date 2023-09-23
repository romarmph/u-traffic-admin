import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    return authStateChanges.when(
      data: (user) {
        if (user == null) {
          return const LoginPage();
        }

        return const PageContainer();
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
      loading: () => const CircularProgressIndicator(),
    );
  }
}
