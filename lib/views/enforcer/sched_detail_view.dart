import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerScheduleDetailView extends ConsumerWidget {
  const EnforcerScheduleDetailView({
    super.key,
    required this.scheduleId,
  });

  final String scheduleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      appBar: AppBar(
        title: const Text('View Schedule'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcerSchedules,
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
                      )
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const SizedBox();
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
