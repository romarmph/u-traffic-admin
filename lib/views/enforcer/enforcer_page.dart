import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerPage extends ConsumerWidget {
  const EnforcerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.enforcers,
      appBar: AppBar(
        title: const Text("Enforcers"),
      ),
      body: const Placeholder(),
    );
  }
}
