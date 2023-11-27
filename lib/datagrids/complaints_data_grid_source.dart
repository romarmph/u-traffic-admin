import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/database/driver_database_providers.dart';
import 'package:u_traffic_admin/views/complaints/complaint_view.dart';

class ComplaintsDataGridSource extends DataGridSource {
  ComplaintsDataGridSource(
    this.complaints,
    this.ref,
  ) {
    _buildRows();
  }

  WidgetRef ref;
  List<Complaint> complaints;

  List<DataGridRow> _complaintsRow = [];

  @override
  List<DataGridRow> get rows => _complaintsRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == ComplaintsGridFields.sender) {
          return Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: ref.watch(getDriverByIdProvider(cell.value.toString())).when(
                  data: (driver) {
                    return Text(
                      '${driver.firstName} ${driver.lastName}',
                      style: const TextStyle(
                        color: UColors.gray500,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: UColors.red400,
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                ),
          );
        }

        if (cell.columnName == ComplaintsGridFields.photo) {
          return Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: ref.watch(getDriverByIdProvider(cell.value.toString())).when(
                  data: (driver) {
                    return CircleAvatar(
                      radius: 20,
                      backgroundImage: CachedNetworkImageProvider(
                        driver.photoUrl,
                      ),
                    );
                  },
                  error: (error, stackTrace) {
                    return const Icon(
                      Icons.error,
                      color: UColors.red400,
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                ),
          );
        }

        if (cell.columnName == ComplaintsGridFields.actions) {
          return Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: UColors.blue400,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(USpace.space8),
                ),
                padding: const EdgeInsets.all(4),
              ),
              onPressed: () {
                Navigator.of(navigatorKey.currentContext!).push(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ComplaintViewPage(
                      complaint: cell.value.toString(),
                    ),
                  ),
                );
              },
              child: const Text('View'),
            ),
          );
        }

        if (cell.columnName == ComplaintsGridFields.status) {
          return Container(
            alignment: Alignment.center,
            child: Chip(
              label: Text(
                cell.value.toString().toUpperCase(),
                style: const TextStyle(
                  color: UColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              side: BorderSide.none,
              backgroundColor: cell.value.toString() == 'open'
                  ? UColors.green400
                  : UColors.blue400,
            ),
          );
        }

        if (cell.columnName == ComplaintsGridFields.createdAt) {
          final date = cell.value as DateTime;
          return Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              date.toTimestamp.toAmericanDate,
              style: const TextStyle(
                color: UColors.gray500,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          );
        }

        if (cell.columnName == ComplaintsGridFields.title ||
            cell.columnName == ComplaintsGridFields.description) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              cell.value.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: UColors.gray500,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            cell.value.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: UColors.gray500,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _complaintsRow = complaints.map((cell) {
      return DataGridRow(cells: [
        DataGridCell<String>(
          columnName: ComplaintsGridFields.photo,
          value: cell.sender,
        ),
        DataGridCell<String>(
          columnName: ComplaintsGridFields.sender,
          value: cell.sender,
        ),
        DataGridCell<String>(
          columnName: ComplaintsGridFields.title,
          value: cell.title,
        ),
        DataGridCell<String>(
          columnName: ComplaintsGridFields.description,
          value: cell.description,
        ),
        DataGridCell<String>(
          columnName: ComplaintsGridFields.status,
          value: cell.status,
        ),
        DataGridCell<DateTime>(
          columnName: ComplaintsGridFields.createdAt,
          value: cell.createdAt.toDate(),
        ),
        DataGridCell<String>(
          columnName: ComplaintsGridFields.actions,
          value: cell.id,
        ),
      ]);
    }).toList();
  }
}
