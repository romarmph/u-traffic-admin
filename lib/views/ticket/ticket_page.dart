import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final pagerController = Provider<DataPagerController>((ref) {
  return DataPagerController();
});

final pageController = Provider<DataGridController>((ref) {
  return DataGridController();
});

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Ticket> tickets = ref.watch(fetchedTicketsProvider);

    return ContentView(
      appBar: const CustomAppBar(
        title: Text('Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(USpace.space12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SfDataGrid(
              controller: ref.watch(pageController),
              gridLinesVisibility: GridLinesVisibility.horizontal,
              columnWidthMode: ColumnWidthMode.auto,
              showHorizontalScrollbar: true,
              source: TicketDataSource(
                ticketdata: tickets,
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
            SfDataPager(
              controller: ref.watch(pagerController),
              pageCount: tickets.isEmpty ? 1 : tickets.length / 10,
              delegate: DataPagerDelegate(),
              availableRowsPerPage: const [10, 20, 30, 40, 50],
            ),
          ],
        ),
      ),
    );
  }
}
