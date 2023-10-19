import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketView extends ConsumerWidget {
  const TicketView({
    super.key,
    required this.ticketID,
  });

  final String ticketID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.tickets,
      appBar: AppBar(
        title: const Text("View Ticket"),
      ),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Back"),
      ),
    );
  }
}
