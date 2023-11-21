import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

List<GridColumn> violationColumns = [
  GridColumn(
    minimumWidth: 150,
    columnName: ViolationFields.name,
    label: const Center(
      child: Text(
        'Violation Name',
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
    columnName: ViolationFields.offenseCount,
    label: const Center(
      child: Text(
        'No. of Offenses',
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
    columnName: ViolationFields.status,
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
    columnName: ViolationFields.createdAt,
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
    minimumWidth: 150,
    columnName: ViolationFields.actions,
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
