import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AdminPage extends ConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.adminStaffs,
      appBar: AppBar(
        title: const Text("Staffs"),
      ),
      body: Placeholder(),
    );
  }
}
