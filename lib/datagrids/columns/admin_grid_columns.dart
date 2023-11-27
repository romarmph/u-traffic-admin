import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> adminGridColumns = [
  GridColumn(
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: AdminGridFields.profilePhoto,
    allowSorting: false,
    allowFiltering: false,
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
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    minimumWidth: 150,
    columnName: AdminGridFields.employeeNumber,
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
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    minimumWidth: 150,
    columnName: AdminGridFields.name,
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
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    minimumWidth: 150,
    columnName: AdminGridFields.email,
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
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    minimumWidth: 150,
    columnName: AdminGridFields.status,
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
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    minimumWidth: 150,
    columnName: AdminGridFields.createdAt,
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
    columnWidthMode: ColumnWidthMode.fitByCellValue,
    minimumWidth: 150,
    columnName: AdminGridFields.actions,
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
