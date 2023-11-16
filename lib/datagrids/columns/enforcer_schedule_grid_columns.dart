import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final List<GridColumn> enforcerSchedGridColumns = [
  GridColumn(
    minimumWidth: 150,
    columnName: EnforcerScheduleGridFields.enforcerId,
    label: const Center(
      child: Text('Enforcer ID'),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: EnforcerScheduleGridFields.shift,
    label: const Center(
      child: Text('Shift'),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: EnforcerScheduleGridFields.startTime,
    label: const Center(
      child: Text('Start Time'),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: EnforcerScheduleGridFields.endTime,
    label: const Center(
      child: Text('End Time'),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: EnforcerScheduleGridFields.postId,
    label: const Center(
      child: Text('Traffic Post'),
    ),
  ),
  GridColumn(
    minimumWidth: 150,
    columnName: EnforcerScheduleGridFields.actions,
    label: const Center(
      child: Text('Actions'),
    ),
  ),
];
