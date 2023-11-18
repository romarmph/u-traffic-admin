import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> enforcerGridColumns = [
  GridColumn(
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerGridFields.photo,
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
    columnName: EnforcerGridFields.employeeNo,
    label: const Center(
      child: Text(
        'Employee No',
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
    columnName: EnforcerGridFields.email,
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
    minimumWidth: 150,
    columnName: EnforcerGridFields.createdAt,
    label: const Center(
      child: Text(
        'Date Created',
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
