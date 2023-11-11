import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> paymentGridColumn = [
  GridColumn(
    minimumWidth: 150,
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: PaymentGridFields.ticketNumber,
    label: const Center(
      child: Text(
        'Ticket No.',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.fineAmount,
    label: const Center(
      child: Text(
        'Fine Amount',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.tenderedAmount,
    label: const Center(
      child: Text(
        'Tendered Amount',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.change,
    label: const Center(
      child: Text(
        'Change',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.processedByName,
    label: const Center(
      child: Text(
        'Cashier',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: PaymentGridFields.datePaid,
    label: const Center(
      child: Text(
        'Date Paid',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    minimumWidth: 150,
    columnName: PaymentGridFields.actions,
    label: const Center(
      child: Text(
        'Actions',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
