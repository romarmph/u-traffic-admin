import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final schedEditModeProvider = StateProvider<String>((ref) => 'swap');

class UpdateEnforcerSchedForm extends ConsumerStatefulWidget {
  const UpdateEnforcerSchedForm({
    super.key,
    required this.schedule,
  });

  final EnforcerSchedule schedule;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateEnforcerSchedFormState();
}

class _UpdateEnforcerSchedFormState
    extends ConsumerState<UpdateEnforcerSchedForm> {
  final _trafficPostSearchController = TextEditingController();
  final _enforcerSearchController = TextEditingController();

  int _flag = 0;

  @override
  void initState() {
    super.initState();
    _trafficPostSearchController.addListener(() {
      ref.read(unassignedTrafficPostSearchProvider.notifier).state =
          _trafficPostSearchController.text;
    });
    _enforcerSearchController.addListener(() {
      ref.read(unassignedEnforcerSearchProvider.notifier).state =
          _enforcerSearchController.text;
    });
  }

  void disposeProvider() {
    ref.invalidate(unassignedEnforcerSearchProvider);
    ref.invalidate(unassignedTrafficPostSearchProvider);
    ref.invalidate(selectedEnforcerProvider);
    ref.invalidate(selectedTrafficPostProvider);
    ref.invalidate(selectedShiftProvider);
  }

  @override
  void dispose() {
    _trafficPostSearchController.dispose();
    _enforcerSearchController.dispose();
    disposeProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selecteShift = ref.watch(selectedShiftProvider);
    final selectedEnforcer = ref.watch(selectedEnforcerProvider);
    final selectedPost = ref.watch(selectedTrafficPostProvider);
    final schedEditMode = ref.watch(schedEditModeProvider);

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
                                setState(() {
                                  _flag = 1;
                                });
                              },
                              value: _flag == 0
                                  ? widget.schedule.shift.name
                                  : selecteShift,
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
                                        : widget.schedule.postId,
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
                                        : widget.schedule.enforcerId,
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
                        ),
                        Visibility(
                          visible: schedEditMode == 'reassign',
                          child: Expanded(
                            child: ScheduleReassignWidget(
                              constraints: constraints,
                              ref: ref,
                              trafficPostSearchController:
                                  _trafficPostSearchController,
                              enforcerSearchController:
                                  _enforcerSearchController,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: schedEditMode == 'swap',
                          child: Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(USpace.space16),
                              decoration: BoxDecoration(
                                  color: UColors.white,
                                  borderRadius: BorderRadius.circular(
                                    USpace.space16,
                                  ),
                                  border: Border.all(
                                    color: UColors.gray300,
                                    width: 1,
                                  )),
                              child: ref.watch(getAllEnforcerSchedStream).when(
                                    data: (schedules) {
                                      schedules.removeWhere(
                                        (element) =>
                                            element.id == widget.schedule.id,
                                      );
                                      return SwapWithSelectionWidget(
                                        schedules: schedules,
                                      );
                                    },
                                    error: (error, stackTrace) {
                                      return const Center(
                                        child: Text('Error fetching schedules'),
                                      );
                                    },
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                            ),
                          ),
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

class SwapWithSelectionWidget extends ConsumerWidget {
  const SwapWithSelectionWidget({
    super.key,
    required this.schedules,
  });

  final List<EnforcerSchedule> schedules;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final sched = schedules[index];

        bool isSelected = ref.watch(selectedSwapWithProvider) != null
            ? ref.watch(selectedSwapWithProvider)!.id == sched.id
            : false;
        return SwapWithSelectionTile(
          isSelected: isSelected,
          schedule: sched,
          onChanged: (value) {
            ref.read(selectedSwapWithProvider.notifier).state = sched;
          },
        );
      },
    );
  }
}

class SwapWithSelectionTile extends ConsumerWidget {
  const SwapWithSelectionTile({
    super.key,
    required this.isSelected,
    required this.schedule,
    required this.onChanged,
  });

  final bool isSelected;
  final EnforcerSchedule schedule;
  final void Function(bool? value)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enforcers = ref.watch(enforcerProvider);
    final trafficPost = ref.watch(trafficPostProvider);

    final enforcer = enforcers.firstWhere(
      (element) => element.id == schedule.enforcerId,
    );

    TrafficPost? post;

    final temp = trafficPost
        .where(
          (element) => element.id == schedule.postId,
        )
        .toList();

    if (temp.isNotEmpty) {
      post = temp.first;
    }

    final String name =
        '${enforcer.firstName} ${enforcer.middleName} ${enforcer.lastName} ${enforcer.suffix}';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? UColors.blue200 : UColors.gray50,
          borderRadius: BorderRadius.circular(
            USpace.space8,
          ),
          border: Border.all(
            color: isSelected ? UColors.blue400 : UColors.gray300,
            width: 1,
          ),
        ),
        child: CheckboxListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: USpace.space16,
            vertical: USpace.space8,
          ),
          value: isSelected,
          title: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: CachedNetworkImageProvider(
                  enforcer.photoUrl,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: USpace.space8),
                        Text(
                          name,
                          style: const TextStyle(
                            color: UColors.gray600,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Chip(
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(USpace.space4),
                          ),
                          backgroundColor: UColors.red500,
                          label: Text(
                            enforcer.employeeNumber.toString(),
                            style: const TextStyle(
                              color: UColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: USpace.space16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _displayPostDetails(schedule.shift, post),
                        const Spacer(),
                        Chip(
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(USpace.space4),
                          ),
                          backgroundColor: schedule.shift == ShiftPeriod.morning
                              ? UColors.blue500
                              : schedule.shift == ShiftPeriod.afternoon
                                  ? UColors.orange500
                                  : UColors.indigo900,
                          label: Text(
                            schedule.shift.name.toUpperCase(),
                            style: const TextStyle(
                              color: UColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _displayPostDetails(ShiftPeriod shift, TrafficPost? post) {
    if (shift == ShiftPeriod.night) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: USpace.space12),
        CircleAvatar(
          radius: 16,
          backgroundColor: UColors.indigo600,
          child: Text(
            post!.number.toString(),
            style: const TextStyle(
              color: UColors.white,
            ),
          ),
        ),
        const SizedBox(width: USpace.space8),
        Text(
          post.name,
          style: const TextStyle(
            color: UColors.gray700,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: USpace.space8),
        Text(
          post.location.address,
          style: const TextStyle(
            color: UColors.gray500,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
