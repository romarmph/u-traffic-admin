import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class UpdateEnforcerSchedForm extends ConsumerWidget {
  const UpdateEnforcerSchedForm({
    super.key,
    required this.scheduleId,
  });

  final String scheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      appBar: AppBar(
        title: const Text('Update Schedule'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcerSchedulesUpdate,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: ref.watch(enforcerSchedByIdStream(scheduleId)).when(
                data: (schedule) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: constraints.maxHeight - 100 - 48,
                        padding: const EdgeInsets.all(USpace.space16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Schedule Information',
                              style: TextStyle(
                                color: UColors.gray400,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(
                              height: USpace.space16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Shift',
                                  style: TextStyle(
                                    color: UColors.gray400,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(
                                  height: USpace.space8,
                                ),
                                Chip(
                                  backgroundColor: schedule.shift ==
                                          ShiftPeriod.morning
                                      ? UColors.blue500
                                      : schedule.shift == ShiftPeriod.afternoon
                                          ? UColors.orange500
                                          : UColors.indigo900,
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: Text(
                                    schedule.shift.name.toUpperCase(),
                                    style: const TextStyle(
                                      color: UColors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: USpace.space16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Enforcer',
                                        style: TextStyle(
                                          color: UColors.gray400,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: USpace.space8,
                                      ),
                                      EnforcerInformationContainer(
                                        enforcerId: schedule.enforcerId,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: USpace.space16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Traffic Post',
                                        style: TextStyle(
                                          color: UColors.gray400,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: USpace.space8,
                                      ),
                                      TrafficPostInformationContainer(
                                        trafficPostId: schedule.postId,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            AuthorWidget(
                              createdBy: schedule.createdBy,
                              updatedBy: schedule.updatedBy,
                              createdAt: schedule.createdAt,
                              updatedAt: schedule.updatedAt,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: USpace.space16,
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(USpace.space16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: USpace.space32,
                                  vertical: USpace.space24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(navigatorKey.currentContext!)
                                    .pop();
                              },
                              child: const Text('Back'),
                            ),
                            const SizedBox(width: USpace.space16),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: USpace.space32,
                                  vertical: USpace.space24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              label: const Text('Update'),
                              icon: const Icon(Icons.edit_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
