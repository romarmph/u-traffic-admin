import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/column_names/attendance_grid_fields.dart';

final List<GridColumn> attendanceGridColumns = [
  GridColumn(
    columnWidthMode: ColumnWidthMode.fill,
    columnName: AttendanceGridFields.enforcerName,
    label: const Center(
      child: Text(
        AttendanceGridFields.enforcerName,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnWidthMode: ColumnWidthMode.fill,
    columnName: AttendanceGridFields.postName,
    label: const Center(
      child: Text(
        AttendanceGridFields.postName,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnWidthMode: ColumnWidthMode.fill,
    columnName: AttendanceGridFields.shift,
    label: const Center(
      child: Text(
        AttendanceGridFields.shift,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnWidthMode: ColumnWidthMode.fill,
    columnName: AttendanceGridFields.timeIn,
    label: const Center(
      child: Text(
        AttendanceGridFields.timeIn,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnWidthMode: ColumnWidthMode.fill,
    columnName: AttendanceGridFields.timeOut,
    label: const Center(
      child: Text(
        AttendanceGridFields.timeOut,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
