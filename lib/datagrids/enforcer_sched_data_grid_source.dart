import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/views/enforcer_sched.riverpod.dart';

class EnforcerScheduleDataGridSource extends DataGridSource {
  EnforcerScheduleDataGridSource(
    this.enforcerSchedules,
    this.ref,
  ) {
    _buildRows();
  }

  WidgetRef ref;
  List<EnforcerSchedule> enforcerSchedules = [];

  List<DataGridRow> _enforcerScheduleRows = [];

  @override
  List<DataGridRow> get rows => _enforcerScheduleRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        ShiftPeriod shift = ShiftPeriod.morning;

        if (cell.columnName == EnforcerScheduleGridFields.shift) {
          shift = cell.value.toString().toLowerCase().toShiftPeriod;
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Chip(
              backgroundColor: shift == ShiftPeriod.morning
                  ? UColors.blue500
                  : shift == ShiftPeriod.afternoon
                      ? UColors.orange500
                      : UColors.indigo900,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              label: Text(
                cell.value.toString().capitalize,
                style: const TextStyle(color: UColors.white),
              ),
            ),
          );
        }

        if (cell.columnName == EnforcerScheduleGridFields.photo) {
          return ref.watch(enforcerProviderById(cell.value.toString())).when(
                data: (data) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: CachedNetworkImageProvider(
                        data.photoUrl,
                      ),
                    ),
                  );
                },
                error: (e, s) => const Icon(Icons.error),
                loading: () => const CircularProgressIndicator(),
              );
        }

        if (cell.columnName == EnforcerScheduleGridFields.createdAt) {
          final date = cell.value as DateTime;

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              date.toTimestamp.toAmericanDate,
            ),
          );
        }

        if (cell.columnName == EnforcerScheduleGridFields.createdBy) {
          return ref.watch(getAdminById(cell.value.toString())).when(
                data: (data) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    alignment: Alignment.center,
                    child: Text('${data.firstName} ${data.lastName}'),
                  );
                },
                error: (e, s) => const Icon(Icons.error),
                loading: () => const CircularProgressIndicator(),
              );
        }

        if (cell.columnName == EnforcerScheduleGridFields.actions) {
          return Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: UColors.blue500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(
                  color: UColors.blue500,
                ),
                padding: const EdgeInsets.all(4),
              ),
              onPressed: () {},
              child: const Text('View'),
            ),
          );
        }

        if (cell.columnName == EnforcerScheduleGridFields.post) {
          if (cell.value.toString().isEmpty) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'No post assigned (Night Shift)',
                style: TextStyle(
                  color: UColors.indigo900,
                ),
              ),
            );
          }

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(cell.value.toString()),
          );
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(cell.value.toString()),
        );
      }).toList(),
    );
  }

  void _buildRows() {
    _enforcerScheduleRows = enforcerSchedules.map<DataGridRow>((cell) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.photo,
            value: cell.enforcerId,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.enforcer,
            value: cell.enforcerName,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.shift,
            value: cell.shift.name.capitalize,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.post,
            value: cell.postName,
          ),
          DataGridCell<DateTime>(
            columnName: EnforcerScheduleGridFields.createdAt,
            value: cell.createdAt.toDate(),
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.actions,
            value: cell.id!,
          ),
        ],
      );
    }).toList();
  }
}
