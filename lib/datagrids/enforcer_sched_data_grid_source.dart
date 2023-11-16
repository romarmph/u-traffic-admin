import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerScheduleDataGridSource extends DataGridSource {
  EnforcerScheduleDataGridSource(
    this.enforcerSchedules,
  ) {
    _buildRows();
  }

  List<EnforcerSchedule> enforcerSchedules = [];

  List<DataGridRow> _enforcerScheduleRows = [];

  @override
  List<DataGridRow> get rows => _enforcerScheduleRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    

    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(e.value.toString()),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _enforcerScheduleRows = enforcerSchedules.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.enforcerId,
            value: e.enforcerId,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.shift,
            value: e.shift.name,
          ),
          DataGridCell<TimePeriod>(
            columnName: EnforcerScheduleGridFields.startTime,
            value: e.startTime,
          ),
          DataGridCell<TimePeriod>(
            columnName: EnforcerScheduleGridFields.endTime,
            value: e.endTime,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.postId,
            value: e.postId,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.actions,
            value: e.id!,
          ),
        ],
      );
    }).toList();
  }
}
