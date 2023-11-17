import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> unassignedGridColumns = [
  GridColumn(
    columnName: UnassignedEnforcerSchedsGridFields.post,
    label: const Center(
      child: Text(
        'Post',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnName: UnassignedEnforcerSchedsGridFields.shift,
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
    columnName: UnassignedEnforcerSchedsGridFields.startTime,
    label: const Center(
      child: Text(
        'Start Time',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnName: UnassignedEnforcerSchedsGridFields.endTime,
    label: const Center(
      child: Text(
        'End Time',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
  GridColumn(
    columnName: UnassignedEnforcerSchedsGridFields.select,
    label: const Center(
      child: Text(
        'Select',
        style: TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  ),
];
