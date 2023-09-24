import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ContentView(
      appBar: const CustomAppBar(
        title: Text('Tickets'),
      ),
      body: Center(child: Text('Ticket Page')),
    );
  }
}
