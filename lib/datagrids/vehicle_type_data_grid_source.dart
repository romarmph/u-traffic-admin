import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class VehicleDataGridSource extends DataGridSource {
  VehicleDataGridSource(
    this.vehicleTypes,
    this.ref,
  ) {
    _buildDataGridRows();
  }
  WidgetRef ref;
  List<VehicleType> vehicleTypes = [];
  List<DataGridRow> _vehicleTypeRows = [];

  @override
  List<DataGridRow> get rows => _vehicleTypeRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        if (cell.columnName == VehicleTypeGridFields.actions) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(4),
                side: const BorderSide(
                  color: UColors.blue500,
                ),
              ),
              onPressed: () {},
              child: const Text('View'),
            ),
          );
        }

        if (cell.columnName == VehicleTypeGridFields.dateCreated ||
            cell.columnName == VehicleTypeGridFields.dateEdited) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              cell.value.toString().toDateTime.toTimestamp.toAmericanDate,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }

        if (cell.columnName == VehicleTypeGridFields.isPublic) {
          final bool isPublic = cell.value == 'Public';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Chip(
              padding: const EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              side: BorderSide.none,
              backgroundColor: isPublic ? UColors.orange500 : UColors.purple500,
              label: Text(
                cell.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        if (cell.columnName == VehicleTypeGridFields.isHidden) {
          final bool isHidden = cell.value == 'Hidden';
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Chip(
              padding: const EdgeInsets.all(4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide.none,
              ),
              side: BorderSide.none,
              backgroundColor: isHidden ? UColors.red500 : UColors.green500,
              label: Text(
                cell.value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                ),
              ),
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

  void _buildDataGridRows() {
    _vehicleTypeRows = vehicleTypes.map<DataGridRow>((vehicleType) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.vehicleType,
            value: vehicleType.typeName,
          ),
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.isPublic,
            value: vehicleType.isPublic ? 'Public' : 'Private',
          ),
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.isHidden,
            value: vehicleType.isHidden ? 'Hidden' : 'Active',
          ),
          DataGridCell<DateTime>(
            columnName: VehicleTypeGridFields.dateCreated,
            value: vehicleType.dateCreated.toDate(),
          ),
          DataGridCell<DateTime>(
            columnName: VehicleTypeGridFields.dateEdited,
            value: vehicleType.dateEdited.toDate(),
          ),
          DataGridCell<String>(
            columnName: VehicleTypeGridFields.actions,
            value: vehicleType.id,
          ),
        ],
      );
    }).toList();
  }
}
