import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class UnassignedEnforcerSchedDataGridSource extends DataGridSource {
  UnassignedEnforcerSchedDataGridSource(
    this.enforcerSchedules,
  ) {
    _buildRows();
  }

  List<EnforcerSchedule> enforcerSchedules = [];

  List<DataGridRow> _enforcerSchedRows = [];

  @override
  List<DataGridRow> get rows => _enforcerSchedRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            cell.value.toString(),
            style: const TextStyle(
              color: UColors.black,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _enforcerSchedRows = enforcerSchedules.map<DataGridRow>((sched) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: UnassignedEnforcerSchedsGridFields.post,
            value: sched.postName,
          ),
          DataGridCell<String>(
            columnName: UnassignedEnforcerSchedsGridFields.shift,
            value: sched.shift.name,
          ),
          DataGridCell<String>(
              columnName: UnassignedEnforcerSchedsGridFields.startTime,
              value: _formatTime(sched.startTime)),
          DataGridCell<String>(
              columnName: UnassignedEnforcerSchedsGridFields.endTime,
              value: _formatTime(sched.endTime)),
          DataGridCell<String>(
            columnName: UnassignedEnforcerSchedsGridFields.select,
            value: sched.id,
          ),
        ],
      );
    }).toList();
  }

  String _formatTime(TimePeriod perdiod) {
    return '${perdiod.hour.toString().padLeft(2, '0')}:${perdiod.minute.toString().padLeft(2, '0')} ${perdiod.period.toUpperCase()}';
  }
}
