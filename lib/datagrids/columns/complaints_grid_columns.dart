import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> complaintGridColumn = [
  GridColumn(
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: ComplaintsGridFields.photo,
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
    minimumWidth: 150,
    columnName: ComplaintsGridFields.title,
    label: const Center(
      child: Text(
        'Sender',
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
    columnName: ComplaintsGridFields.title,
    label: const Center(
      child: Text(
        'Title',
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
    columnName: ComplaintsGridFields.description,
    label: const Center(
      child: Text(
        'Description',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: ComplaintsGridFields.status,
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
    columnName: ComplaintsGridFields.createdAt,
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
    allowSorting: false,
    allowFiltering: false,
    columnName: ComplaintsGridFields.createdAt,
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
