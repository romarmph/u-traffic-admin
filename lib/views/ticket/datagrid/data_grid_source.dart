import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDataGridSource extends DataGridSource {
  TicketDataGridSource(this.ticketList) {
    buildDataGridRows();
  }

  List<Ticket> ticketList = [];

  List<DataGridRow> _ticketRows = [];

  @override
  List<DataGridRow> get rows => _ticketRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == TicketGridFields.actions) {
          return Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: USpace.space8,
                  horizontal: USpace.space16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(USpace.space8),
                ),
                side: const BorderSide(color: UColors.blue600),
              ),
              onPressed: () {
                goToTicketView(dataGridCell.value);
              },
              child: const Text('View'),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    ).toList());
  }

  void buildDataGridRows() {
    _ticketRows = ticketList
        .map<DataGridRow>((ticket) => DataGridRow(
              cells: [
                DataGridCell<int>(
                  columnName: TicketGridFields.ticketNumber,
                  value: ticket.ticketNumber,
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
                DataGridCell<double>(
                  columnName: TicketGridFields.totalFine,
                  value: ticket.totalFine,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.status,
                  value: ticket.status.toString().split('.').last,
                ),
                DataGridCell<String>(
                  columnName: TicketGridFields.actions,
                  value: ticket.id,
                ),
              ],
            ))
        .toList();
  }
}
