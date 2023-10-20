import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketPage extends ConsumerStatefulWidget {
  const TicketPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TicketPageState();
}

class _TicketPageState extends ConsumerState<TicketPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return PageContainer(
      route: Routes.tickets,
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Container(
              color: UColors.white,
              height: 100,
              child: Text("Header"),
            ),
          ),
          const TicketDataGrid()
        ],
      ),
    );
  }
}
