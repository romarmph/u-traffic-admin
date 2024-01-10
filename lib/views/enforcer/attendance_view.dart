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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Attendance",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: ref.watch(dayProvider).toDate(),
                            firstDate: ref.watch(dayProvider).toDate(),
                            lastDate: DateTime(2025),
                          );
                          if (date != null) {
                            ref.read(dayProvider.notifier).state =
                                Timestamp.fromDate(date);
                          }
                        },
                        child: Text(
                          DateFormat.yMMMMd()
                              .format(ref.watch(dayProvider).toDate()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: USpace.space16),
                  Expanded(
                    child: ref
                        .watch(attendanceProvider(ref.watch(dayProvider)))
                        .when(
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final dayProvider = StateProvider<Timestamp>((ref) {
  return Timestamp.fromDate(DateTime.now());
});
