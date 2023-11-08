import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> ticketGridColumns = [
  GridColumn(
    minimumWidth: 150,
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: TicketGridFields.ticketNumber,
    label: const Center(
      child: Text(
        'Ticket No.',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.licenseNumber,
    label: const Center(
      child: Text(
        'License No.',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.driverName,
    label: const Center(
      child: Text(
        'Driver Name',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.dateCreated,
    label: const Center(
      child: Text(
        'Date Issued',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.dateCreated,
    label: const Center(
      child: Text(
        'Due Date',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.totalFine,
    label: const Center(
      child: Text(
        'Fina Amount',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.status,
    label: const Center(
      child: Text(
        'Status',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: TicketGridFields.status,
    label: const Center(
      child: Text(
        'Actions',
      ),
    ),
  ),
];
