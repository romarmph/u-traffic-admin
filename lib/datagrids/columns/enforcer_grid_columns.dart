import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> enforcerGridColumns = [
  GridColumn(
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    columnName: EnforcerGridFields.name,
    allowFiltering: false,
    allowSorting: false,
    label: const Center(
      child: Text(
        '',
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
    columnName: EnforcerGridFields.name,
    label: const Center(
      child: Text(
        'Name',
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
    columnName: EnforcerGridFields.shift,
    label: const Center(
      child: Text(
        'Email',
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
    columnName: EnforcerGridFields.status,
    label: const Center(
      child: Text(
        'Shift',
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
    columnName: EnforcerGridFields.status,
    label: const Center(
      child: Text(
        'Status',
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
    columnName: EnforcerGridFields.action,
    label: const Center(
      child: Text(
        'Action',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
