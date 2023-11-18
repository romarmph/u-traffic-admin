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
            columnName: EnforcerScheduleGridFields.startTime,
            value: _formatTime(cell.startTime),
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.endTime,
            value: _formatTime(cell.endTime),
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.post,
            value: cell.postName,
          ),
          DataGridCell<String>(
            columnName: EnforcerScheduleGridFields.actions,
            value: cell.id!,
          ),
        ],
      );
    }).toList();
  }

  String _formatTime(TimePeriod perdiod) {
    return '${perdiod.hour.toString().padLeft(2, '0')}:${perdiod.minute.toString().padLeft(2, '0')} ${perdiod.period.toUpperCase()}';
  }
}
