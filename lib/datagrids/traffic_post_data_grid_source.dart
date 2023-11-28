import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class TrafficPostDataGridSource extends DataGridSource {
  TrafficPostDataGridSource(
    this.trafficPost,
  ) {
    _buildDataGridRows();
  }

  List<TrafficPost> trafficPost = [];

  List<DataGridRow> _trafficRows = [];

  @override
  List<DataGridRow> get rows => _trafficRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == TrafficPostFields.createdAt ||
            cell.columnName == TrafficPostFields.updatedAt) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              cell.value.toString().toDateTime.toTimestamp.toAmericanDate,
            ),
          );
        }

        if (cell.columnName == TrafficPostFields.action) {
          return Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(USpace.space8),
                ),
                side: const BorderSide(
                  color: UColors.blue400,
                ),
              ),
              onPressed: () {},
              child: const Text('View'),
            ),
          );
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            cell.value.toString(),
          ),
        );
      }).toList(),
    );
  }

  void _buildDataGridRows() {
    _trafficRows = trafficPost.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(
          columnName: TrafficPostFields.number,
          value: dataGridRow.number,
        ),
        DataGridCell<String>(
          columnName: TrafficPostFields.name,
          value: dataGridRow.name,
        ),
        DataGridCell<String>(
          columnName: TrafficPostFields.location,
          value: dataGridRow.location.address,
        ),
        DataGridCell<DateTime>(
          columnName: TrafficPostFields.createdAt,
          value: dataGridRow.createdAt.toDate(),
        ),
        DataGridCell<String>(
          columnName: TrafficPostFields.action,
          value: dataGridRow.id,
        ),
      ]);
    }).toList();
  }
}
