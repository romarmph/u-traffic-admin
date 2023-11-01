import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.home,
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: const Placeholder(),
    );
  }
}
