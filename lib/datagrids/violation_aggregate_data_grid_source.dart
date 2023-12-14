import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/column_names/violation_aggregate_grid_fields.dart';
import 'package:u_traffic_admin/model/analytics/violation_data.dart';

class ViolationsAggregateDataGridSource extends DataGridSource {
  ViolationsAggregateDataGridSource(this.violations) {
    _buildRows();
  }

  final List<ViolationData> violations;

  List<DataGridRow> _dataRows = [];

  @override
  List<DataGridRow> get rows => _dataRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            e.value.toString(),
            style: const TextStyle(
              color: UColors.gray500,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _dataRows = violations.map<DataGridRow>((e) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: ViolationsAggregateGridFields.violation,
            value: e.name,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.total,
            value: e.total,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.monday,
            value: e.mondayCount,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.tuesday,
            value: e.tuesdayCount,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.wednesday,
            value: e.wednesdayCount,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.thursday,
            value: e.thursdayCount,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.friday,
            value: e.fridayCount,
          ),
          DataGridCell<int>(
            columnName: ViolationsAggregateGridFields.saturday,
            value: e.saturdayCount,
          ),
        ],
      );
    }).toList();
  }
}
