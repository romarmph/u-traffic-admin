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
      body: Padding(
        padding: const EdgeInsets.all(USpace.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.horizontal,
              
              columnWidthMode: ColumnWidthMode.auto,
              source: TicketDataSource(
                ticketdata: ref.watch(fetchedTicketsProvider),
              ),
              columns: [
                GridColumn(
                  columnName: TicketGridFields.ticketNumber,
                  label: const Text('Ticket No.'),
                ),
                GridColumn(
                  columnName: TicketGridFields.driverName,
                  label: const Text('Driver Name'),
                ),
                GridColumn(
                  columnName: TicketGridFields.licenseNumber,
                  label: const Text('License No.'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
