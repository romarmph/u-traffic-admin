import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.analytics,
      appBar: AppBar(
        title: const Text("Analytics"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container()
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
