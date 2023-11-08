import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/constants/payment_grid_fields.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> paymentGridColumn = [
  GridColumn(
    minimumWidth: 150,
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: PaymentGridFields.ticketNumber,
    label: const Center(
      child: Text(
        'Ticket No.',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.fineAmount,
    label: const Center(
      child: Text(
        'Fine Amount',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.tenderedAmount,
    label: const Center(
      child: Text(
        'Tendered Amount',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.change,
    label: const Center(
      child: Text(
        'Change',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.processedBy,
    label: const Center(
      child: Text(
        'Cashier',
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.datePaid,
    label: const Center(
      child: Text(
        'Date Paid',
      ),
    ),
  ),
];
