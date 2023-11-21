import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final schedEditModeProvider = StateProvider<String>((ref) => 'swap');

class UpdateEnforcerSchedForm extends ConsumerWidget {
  const UpdateEnforcerSchedForm({
    super.key,
    required this.schedule,
  });

  final EnforcerSchedule schedule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selecteShift = ref.watch(selectedShiftProvider);
    final selectedEnforcer = ref.watch(selectedEnforcerProvider);
    final selectedPost = ref.watch(selectedTrafficPostProvider);
    final schedEditMode = ref.watch(schedEditModeProvider);

    print(schedule.shift.name == selecteShift
        ? selecteShift
        : schedule.shift.name);

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
              child: Column(
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
                            StatusTypeDropDown(
                              statusList: const [
                                'morning',
                                'afternoon',
                                'night',
                              ],
                              onChanged: (value) {
                                ref.read(selectedShiftProvider.notifier).state =
                                    value!;
                              },
                              value: schedule.shift.name == selecteShift
                                  ? selecteShift
                                  : schedule.shift.name,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    enforcerId: selectedEnforcer != null
                                        ? selectedEnforcer.id!
                                        : schedule.enforcerId,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: USpace.space16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    trafficPostId: selectedPost != null
                                        ? selectedPost.id!
                                        : schedule.postId,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ChoiceChip(
                              label: const Text('Reassign'),
                              selected: schedEditMode != 'swap',
                              onSelected: (value) {
                                ref.read(schedEditModeProvider.notifier).state =
                                    'reassign';
                              },
                            ),
                            const SizedBox(
                              width: USpace.space16,
                            ),
                            ChoiceChip(
                              label: const Text('Swap'),
                              selected: schedEditMode == 'swap',
                              onSelected: (value) {
                                ref.read(schedEditModeProvider.notifier).state =
                                    'swap';
                              },
                            ),
                          ],
                        )
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
                            Navigator.of(navigatorKey.currentContext!).pop();
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
              ),
            ),
          );
        },
      ),
    );
  }
}
