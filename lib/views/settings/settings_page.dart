import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.settings,
      appBar: AppBar(
        title: const Text("Settings"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
