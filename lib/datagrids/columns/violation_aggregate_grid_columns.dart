import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/column_names/violation_aggregate_grid_fields.dart';

final List<GridColumn> violationsAggregateGridColumns = [
  GridColumn(
    minimumWidth: 150,
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.violation,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.violation,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.total,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.total,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.monday,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.monday,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.tuesday,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.tuesday,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.wednesday,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.wednesday,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.thursday,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.thursday,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.friday,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.friday,
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
    columnWidthMode: ColumnWidthMode.fill,
    columnName: ViolationsAggregateGridFields.saturday,
    label: const Center(
      child: Text(
        ViolationsAggregateGridFields.saturday,
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
