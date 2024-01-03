import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/attendance_data_grid_source.dart';
import 'package:u_traffic_admin/datagrids/columns/attendance_grid_columns.dart';
import 'package:u_traffic_admin/riverpod/database/attendance_database_providers.dart';

class EnforcerAttendancePage extends ConsumerWidget {
  const EnforcerAttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      route: Routes.enforcerAttendance,
      appBar: AppBar(
        title: const Text("Enforcers"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space16),
              ),
              child: SizedBox(
                width: constraints.maxWidth,
                child: ref.watch(attendanceProvider).when(
                      data: (attendance) {
                        return DataGridContainer(
                          constraints: constraints,
                          source: AttendanceDataGridSource(
                            attendance,
                          ),
                          gridColumns: attendanceGridColumns,
                          dataCount: attendance.length,
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
