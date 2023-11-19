import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AdminDataGridSource extends DataGridSource {
  AdminDataGridSource(
    this.adminList,
  ) {
    _buildRows();
  }

  List<Admin> adminList = [];

  List<DataGridRow> _adminRows = [];

  @override
  List<DataGridRow> get rows => _adminRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == AdminGridFields.actions) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              onPressed: () {},
              child: const Text('View'),
            ),
          );
        }

        if (cell.columnName == AdminGridFields.status) {
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
                cell.value.toString().capitalize,
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        if (cell.columnName == AdminGridFields.profilePhoto) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: CachedNetworkImageProvider(
                cell.value.toString(),
              ),
            ),
          );
        }

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
      }).toList(),
    );
  }

  void _buildRows() {
    _adminRows = adminList.map<DataGridRow>(
      (admin) {
        final name =
            '${admin.firstName} ${admin.middleName} ${admin.lastName} ${admin.suffix}';
        return DataGridRow(
          cells: [
            DataGridCell<String>(
              columnName: AdminGridFields.profilePhoto,
              value: admin.photoUrl,
            ),
            DataGridCell<String>(
              columnName: AdminGridFields.employeeNumber,
              value: admin.employeeNo,
            ),
            DataGridCell<String>(
              columnName: AdminGridFields.name,
              value: name,
            ),
            DataGridCell<String>(
              columnName: AdminGridFields.email,
              value: admin.email,
            ),
            DataGridCell<String>(
              columnName: AdminGridFields.status,
              value: admin.status.name,
            ),
            DataGridCell<DateTime>(
              columnName: AdminGridFields.createdAt,
              value: admin.createdAt.toDate(),
            ),
            DataGridCell<String>(
              columnName: AdminGridFields.actions,
              value: admin.id,
            ),
          ],
        );
      },
    ).toList();
  }
}
