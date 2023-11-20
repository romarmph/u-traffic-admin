import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> enforcerSchedGridColumns = [
  GridColumn(
    allowFiltering: false,
    allowSorting: false,
    columnWidthMode: ColumnWidthMode.fitByColumnName,
    columnName: EnforcerScheduleGridFields.photo,
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
    columnName: EnforcerScheduleGridFields.enforcer,
    label: const Center(
      child: Text(
        'Enforcer',
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
    columnName: EnforcerScheduleGridFields.shift,
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
    columnName: EnforcerScheduleGridFields.post,
    label: const Center(
      child: Text(
        'Traffic Post',
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
    columnName: EnforcerScheduleGridFields.post,
    label: const Center(
      child: Text(
        'Created By',
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
    columnName: EnforcerScheduleGridFields.post,
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
    columnName: EnforcerScheduleGridFields.actions,
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
