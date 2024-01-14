import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/column_names/attendance_grid_fields.dart';
import 'package:u_traffic_admin/model/attendance.dart';

class AttendanceDataGridSource extends DataGridSource {
  AttendanceDataGridSource(
    this.attendance,
  ) {
    buildDataGridRows();
  }

  List<Attendance> attendance;

  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            cell.value.toString(),
            style: const TextStyle(
              color: UColors.gray500,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }).toList(growable: false),
    );
  }

  void buildDataGridRows() {
    _dataGridRows = attendance.map<DataGridRow>((attendance) {
      return DataGridRow(cells: [
        DataGridCell<String>(
          columnName: AttendanceGridFields.enforcerName,
          value: attendance.schedule.enforcerName,
        ),
        DataGridCell<String>(
          columnName: AttendanceGridFields.postName,
          value: attendance.schedule.postName,
        ),
        DataGridCell<String>(
          columnName: AttendanceGridFields.shift,
          value: attendance.schedule.shift.name.capitalize,
        ),
        DataGridCell<String>(
          columnName: AttendanceGridFields.timeIn,
          value: attendance.timeIn.toAmericanDateWithTime,
        ),
        DataGridCell<String>(
          columnName: AttendanceGridFields.timeOut,
          value: attendance.timeOut == null
              ? ''
              : attendance.timeOut!.toAmericanDateWithTime,
        ),
      ]);
    }).toList(growable: false);
  }
}
