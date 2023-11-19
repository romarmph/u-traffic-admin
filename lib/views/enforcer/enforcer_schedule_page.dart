import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerSchedulePage extends ConsumerStatefulWidget {
  const EnforcerSchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnforcerSchedulePageState();
}

class _EnforcerSchedulePageState extends ConsumerState<EnforcerSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.enforcerSchedules,
      appBar: AppBar(
        title: const Text("Enforcer Schedules"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SystemMenu(
                  route: Routes.systemEnforcerSchedule,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Container(
                      width: constraints.maxWidth - 32,
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space12),
                      ),
                      child: ref.watch(getAllEnforcerSchedStream).when(
                        data: (data) {
                          return DataGridContainer(
                            constraints: constraints,
                            source: EnforcerScheduleDataGridSource(
                              data,
                              ref,
                            ),
                            gridColumns: enforcerSchedGridColumns,
                            dataCount: data.length,
                          );
                        },
                        error: (error, stackTrace) {
                          return const Center(
                            child: Text(
                              'Error fetching enforcer schedules',
                            ),
                          );
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
