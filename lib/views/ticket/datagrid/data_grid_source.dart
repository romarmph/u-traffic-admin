import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDataSource extends DataGridSource {
  TicketDataSource({
    required List<Ticket> ticketdata,
    required WidgetRef ref,
  }) {
    _ref = ref;
    _ticketdata = ticketdata
        .map<DataGridRow>(
          (ticket) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: TicketGridFields.ticketNumber,
                value: ticket.ticketNumber.toString(),
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.licenseNumber,
                value: ticket.licenseNumber,
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.driverName,
                value: ticket.driverName,
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.dateCreated,
                value: ticket.dateCreated.toAmericanDate,
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.totalFine,
                value: ticket.totalFine.toString(),
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.status,
                value: ticket.status.toString().split('.').last.toUpperCase(),
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.actions,
                value: ticket.id,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _ticketdata = [];
  late WidgetRef _ref;

  @override
  List<DataGridRow> get rows => _ticketdata;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final isDarkMode = _ref.watch(isDarkModeProvider);

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.columnName == TicketGridFields.status) {
        Color statusColor = UColors.gray400;

        if (e.value.toString().toUpperCase() == 'PAID') {
          statusColor = UColors.green400;
        } else if (e.value.toString().toUpperCase() == 'UNPAID') {
          statusColor = UColors.red400;
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Card(
              color: statusColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  e.value.toString(),
                  style: const TextStyle(
                    color: UColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }

      if (e.columnName == TicketGridFields.actions) {
        return Center(
          child: TextButton(
            onPressed: () {
              goToTicketView(e.value);
            },
            child: const Text('View'),
          ),
        );
      }

      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          style: TextStyle(
              color: isDarkMode ? UColors.gray400 : UColors.gray500,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      );
    }).toList());
  }
}
