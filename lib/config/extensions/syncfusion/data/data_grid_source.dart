import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TicketDataSource extends DataGridSource {
  TicketDataSource({
    required List<Ticket> ticketdata,
  }) {
    _ticketdata = ticketdata
        .map<DataGridRow>(
          (ticket) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: TicketGridFields.ticketNumber,
                value: ticket.ticketNumber.toString(),
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.driverName,
                value: ticket.driverName,
              ),
              DataGridCell<String>(
                columnName: TicketGridFields.licenseNumber,
                value: ticket.licenseNumber,
              ),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _ticketdata = [];

  @override
  List<DataGridRow> get rows => _ticketdata;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
