import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/views/enforcer_sched.riverpod.dart';

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

class EnforcerInformationContainer extends ConsumerWidget {
  const EnforcerInformationContainer({
    super.key,
    required this.enforcerId,
  });

  final String enforcerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(USpace.space16),
      decoration: BoxDecoration(
        border: Border.all(
          color: UColors.gray300,
        ),
        borderRadius: BorderRadius.circular(
          USpace.space8,
        ),
      ),
      child: ref.watch(enforcerProviderById(enforcerId)).when(
        data: (data) {
          return Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: CachedNetworkImageProvider(
                  data.photoUrl,
                ),
              ),
              const SizedBox(
                width: USpace.space16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${data.firstName} ${data.middleName} ${data.lastName} ${data.suffix}',
                    style: const TextStyle(
                      color: UColors.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: USpace.space8,
                  ),
                  Text(
                    data.email,
                    style: const TextStyle(
                      color: UColors.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        error: (e, s) {
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
    );
  }
}

class TrafficPostInformationContainer extends ConsumerWidget {
  const TrafficPostInformationContainer({
    super.key,
    required this.trafficPostId,
  });

  final String trafficPostId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(USpace.space16),
      decoration: BoxDecoration(
        border: Border.all(
          color: UColors.gray300,
        ),
        borderRadius: BorderRadius.circular(
          USpace.space8,
        ),
      ),
      child: ref.watch(trafficPostProviderById(trafficPostId)).when(
        data: (data) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: UColors.blue500,
                child: Text(
                  data.number.toString(),
                  style: const TextStyle(
                    color: UColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                width: USpace.space16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(
                      color: UColors.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: USpace.space8,
                  ),
                  Text(
                    data.location.address,
                    style: const TextStyle(
                      color: UColors.gray400,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        error: (e, s) {
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
    );
  }
}
