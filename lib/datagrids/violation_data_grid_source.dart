import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class ViolationsDataGridSource extends DataGridSource {
  ViolationsDataGridSource(
    this.violationsList,
  ) {
    _buildRows();
  }

  List<Violation> violationsList = [];
  List<DataGridRow> _violationRows = [];

  @override
  List<DataGridRow> get rows => _violationRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == ViolationFields.status) {
          final status = cell.value as bool ? "Disabled" : "Enabled";
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              status,
              style: TextStyle(
                color: cell.value as bool ? UColors.red500 : UColors.green500,
              ),
            ),
          );
        }

        if (cell.columnName == ViolationFields.actions) {
          return Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(USpace.space8),
                ),
                side: const BorderSide(color: UColors.blue600),
              ),
              onPressed: () {},
              child: const Text('View'),
            ),
          );
        }

        if (cell.columnName == ViolationFields.offenseCount) {
          Color bgColor = UColors.blue600;

          if (cell.value == 0) {
            bgColor = UColors.red500;
          } else if (cell.value == 1) {
            bgColor = UColors.green500;
          } else if (cell.value == 2) {
            bgColor = UColors.yellow500;
          } else if (cell.value == 3) {
            bgColor = UColors.orange500;
          } else {
            bgColor = UColors.blue600;
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: bgColor,
              child: Text(
                cell.value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        if (cell.columnName == ViolationFields.createdAt ||
            cell.columnName == ViolationFields.updatedAt) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString().toDateTime.toTimestamp.toAmericanDate,
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          alignment: Alignment.center,
          child: Text(
            cell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _violationRows = violationsList.map<DataGridRow>((cell) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: ViolationFields.name,
            value: cell.name,
          ),
          DataGridCell<int>(
            columnName: ViolationFields.offenseCount,
            value: cell.offense.length,
          ),
          DataGridCell<bool>(
            columnName: ViolationFields.status,
            value: cell.isDisabled,
          ),
          DataGridCell<DateTime>(
            columnName: ViolationFields.createdAt,
            value: cell.dateCreated.toDate(),
          ),
          DataGridCell<String>(
            columnName: ViolationFields.actions,
            value: cell.id,
          ),
        ],
      );
    }).toList();
  }
}
