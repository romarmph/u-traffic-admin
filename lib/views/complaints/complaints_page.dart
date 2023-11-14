import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ComplaintsPage extends ConsumerWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.complaints,
      appBar: AppBar(
        title: const Text("Complaints"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
