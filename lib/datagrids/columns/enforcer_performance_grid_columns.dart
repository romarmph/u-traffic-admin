import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/column_names/enforcer_performance_grid_field.dart';

final List<GridColumn> enforcerPerformanceGridColumns = [
  GridColumn(
    minimumWidth: 150,
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.enforcerName,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.enforcerName,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totalTickets,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totalTickets,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totalPaidTickets,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totalPaidTickets,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totalUnpaidTickets,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totalUnpaidTickets,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totalCancelledTickets,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totalCancelledTickets,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totaloverdueTickets,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totaloverdueTickets,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totalAmountPaid,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totalAmountPaid,
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
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerPerformanceGridFields.totalAmountUnpaid,
    label: const Center(
      child: Text(
        EnforcerPerformanceGridFields.totalAmountUnpaid,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
