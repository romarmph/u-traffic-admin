import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDataGridSource extends DataGridSource {
  TicketDataGridSource(this.tickets, this.rowsPerPage) {
    _paginatedTickets = tickets.getRange(0, rowsPerPage).toList();
    buildDataGridRows();
  }
  late int rowsPerPage;
  late List<Ticket> _paginatedTickets;
  late List<Ticket> tickets;
  late List<DataGridRow> dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == TicketGridFields.actions) {
          return Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('View'),
            ),
          );
        }

        return Center(
          child: Text(dataGridCell.value.toString()),
        );
      }).toList(growable: false),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;

    if (endIndex > tickets.length) {
      endIndex = tickets.length;
    }

    if (startIndex < tickets.length && endIndex <= tickets.length) {
      _paginatedTickets =
          tickets.getRange(startIndex, endIndex).toList(growable: false);
      buildDataGridRows();
      notifyListeners();
    } else {
      _paginatedTickets = [];
    }

    return true;
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRows() {
    dataGridRows = _paginatedTickets.map<DataGridRow>((ticket) {
      return DataGridRow(
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
      );
    }).toList(growable: false);
  }
}
