import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerDataGridSource extends DataGridSource {
  EnforcerDataGridSource(
    this.enforcers,
    this.ref,
  ) {
    _buildRows();
  }

  WidgetRef ref;
  List<Enforcer> enforcers = [];

  List<DataGridRow> _enforcerRows = [];

  @override
  List<DataGridRow> get rows => _enforcerRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == EnforcerGridFields.action) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: UColors.blue500,
                  side: const BorderSide(
                    color: UColors.blue500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(USpace.space8),
                  ),
                  padding: const EdgeInsets.all(4),
                ),
                onPressed: () {
                  goToEnforcerDetailsPage(cell.value);
                },
                child: const Text('View'),
              ),
            ),
          );
        }

        if (cell.columnName == EnforcerGridFields.employeeNo) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              cell.value,
              style: const TextStyle(
                color: UColors.black,
                fontSize: 14,
              ),
            ),
          );
        }

        if (cell.columnName == EnforcerGridFields.status) {
          Color color;

          switch (cell.value.toString().toLowerCase()) {
            case 'active':
              color = UColors.blue400;
              break;
            case 'offduty':
              color = UColors.red400;
              break;
            case 'onduty':
              color = UColors.green400;
              break;
            case 'onleave':
              color = UColors.yellow400;
              break;
            case 'suspended':
              color = UColors.purple400;
              break;
            default:
              color = UColors.gray400;
              break;
          }

          return Center(
            child: Chip(
              side: BorderSide.none,
              backgroundColor: color,
              label: Text(
                cell.value,
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        if (cell.columnName == EnforcerGridFields.createdAt) {
          final date = cell.value as DateTime;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              date.toTimestamp.toAmericanDate,
              style: const TextStyle(
                color: UColors.black,
                fontSize: 14,
              ),
            ),
          );
        }

        if (cell.columnName == EnforcerGridFields.photo) {
          return Container(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 32,
              backgroundImage: CachedNetworkImageProvider(
                cell.value.toString(),
              ),
            ),
          );
        }

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
    _enforcerRows = enforcers.map<DataGridRow>((enforcer) {
      final name =
          '${enforcer.firstName} ${enforcer.middleName} ${enforcer.lastName} ${enforcer.suffix}';
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: EnforcerGridFields.photo,
            value: enforcer.photoUrl,
          ),
          DataGridCell<String>(
            columnName: EnforcerGridFields.employeeNo,
            value: enforcer.employeeNumber,
          ),
          DataGridCell<String>(
            columnName: EnforcerGridFields.name,
            value: name,
          ),
          DataGridCell<String>(
            columnName: EnforcerGridFields.email,
            value: enforcer.email,
          ),
          DataGridCell<String>(
            columnName: EnforcerGridFields.status,
            value: enforcer.status.name.capitalize,
          ),
          DataGridCell<DateTime>(
            columnName: EnforcerGridFields.createdAt,
            value: enforcer.createdAt.toDate(),
          ),
          DataGridCell<String>(
            columnName: EnforcerGridFields.action,
            value: enforcer.id,
          ),
        ],
      );
    }).toList();
  }
}
