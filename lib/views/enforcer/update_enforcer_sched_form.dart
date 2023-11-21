import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final schedEditModeProvider = StateProvider<String>((ref) => 'reassign');

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
  final _scheduleSearchController = TextEditingController();

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
    _scheduleSearchController.addListener(() {
      ref.read(scheduleSearchProvider.notifier).state =
          _scheduleSearchController.text;
    });
  }

  void _onUpdateButtonTap() async {
    final schedEditMode = ref.watch(schedEditModeProvider);

    if (schedEditMode == 'swap') {
      _swapSchedule();
      return;
    } else {
      _reassignSchedule();
      return;
    }
  }

  void _swapSchedule() async {
    final selectedSwapWith = ref.watch(selectedSwapWithProvider);

    if (selectedSwapWith == null) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please select a schedule to swap with',
      );
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Swapping schedule',
      text: 'Please wait...',
    );

    final currentAdmin = ref.watch(currentAdminProvider);

    final currentSchedule = widget.schedule.copyWith(
      enforcerId: selectedSwapWith.enforcerId,
      postId: selectedSwapWith.postId,
      shift: widget.schedule.shift,
      enforcerName: selectedSwapWith.enforcerName,
      postName: selectedSwapWith.postName,
      updatedAt: Timestamp.now(),
      updatedBy: currentAdmin.id,
    );

    final selectedSchedule = selectedSwapWith.copyWith(
      enforcerId: widget.schedule.enforcerId,
      postId: widget.schedule.postId,
      shift: selectedSwapWith.shift,
      enforcerName: widget.schedule.enforcerName,
      postName: widget.schedule.postName,
      updatedAt: Timestamp.now(),
      updatedBy: currentAdmin.id,
    );

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(
          FirebaseFirestore.instance.collection('enforcerSchedules').doc(
                currentSchedule.id,
              ),
          currentSchedule.toJson(),
        );
        transaction.update(
          FirebaseFirestore.instance.collection('enforcerSchedules').doc(
                selectedSchedule.id,
              ),
          selectedSchedule.toJson(),
        );
      });
    } catch (e) {
      Navigator.of(navigatorKey.currentContext!).pop();
      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error swapping schedule',
      );
      return;
    }
    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Schedule swapped successfully',
    );

    Navigator.of(navigatorKey.currentContext!).pop();
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  void _reassignSchedule() async {
    final selectedNewEnforcer = ref.watch(selectedEnforcerProvider);
    final selectedNewPost = ref.watch(selectedTrafficPostProvider);
    final selectedShift = ref.watch(selectedShiftProvider);

    if (selectedShift != 'night' &&
        (selectedNewEnforcer == null && selectedNewPost == null)) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please select a new enforcer or traffic post',
      );
      return;
    }

    QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.loading,
      title: 'Reassigning schedule',
      text: 'Please wait...',
    );

    final currentAdmin = ref.watch(currentAdminProvider);

    EnforcerSchedule newSchedule;

    if (selectedShift == 'night') {
      newSchedule = widget.schedule.copyWith(
        enforcerId: selectedNewEnforcer != null
            ? selectedNewEnforcer.id
            : widget.schedule.enforcerId,
        postId: "",
        shift: selectedShift.toLowerCase().toShiftPeriod,
        enforcerName: selectedNewEnforcer != null
            ? '${selectedNewEnforcer.firstName} ${selectedNewEnforcer.middleName} ${selectedNewEnforcer.lastName} ${selectedNewEnforcer.suffix}'
            : widget.schedule.enforcerName,
        postName: "",
        updatedAt: Timestamp.now(),
        updatedBy: currentAdmin.id,
      );
    } else {
      newSchedule = widget.schedule.copyWith(
        enforcerId: selectedNewEnforcer != null
            ? selectedNewEnforcer.id
            : widget.schedule.enforcerId,
        postId: selectedNewPost != null
            ? selectedNewPost.id
            : widget.schedule.postId,
        shift: selectedShift.toLowerCase().toShiftPeriod,
        enforcerName: selectedNewEnforcer != null
            ? '${selectedNewEnforcer.firstName} ${selectedNewEnforcer.middleName} ${selectedNewEnforcer.lastName} ${selectedNewEnforcer.suffix}'
            : widget.schedule.enforcerName,
        postName: selectedNewPost != null
            ? selectedNewPost.name
            : widget.schedule.postName,
        updatedAt: Timestamp.now(),
        updatedBy: currentAdmin.id,
      );
    }

    try {
      await EnforcerScheduleDatabse.instance.updateEnforcerSched(
        newSchedule,
      );
    } catch (e) {
      Navigator.of(navigatorKey.currentContext!).pop();
      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error reassigning schedule',
      );
      return;
    }

    await QuickAlert.show(
      context: navigatorKey.currentContext!,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Schedule reassigned successfully',
    );

    Navigator.of(navigatorKey.currentContext!).pop();
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  void disposeProvider() {
    ref.invalidate(unassignedEnforcerSearchProvider);
    ref.invalidate(unassignedTrafficPostSearchProvider);
    ref.invalidate(selectedEnforcerProvider);
    ref.invalidate(selectedTrafficPostProvider);
    ref.invalidate(selectedShiftProvider);
    ref.invalidate(selectedSwapWithProvider);
  }

  @override
  void dispose() {
    _trafficPostSearchController.dispose();
    _enforcerSearchController.dispose();
    _scheduleSearchController.dispose();
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
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: _scheduleSearchController,
                                decoration: InputDecoration(
                                  hintText: 'Search schedule',
                                  prefixIcon: const Icon(Icons.search_rounded),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      USpace.space8,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
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
                              padding: const EdgeInsets.all(USpace.space8),
                              decoration: BoxDecoration(
                                color: UColors.white,
                                borderRadius: BorderRadius.circular(
                                  USpace.space16,
                                ),
                                border: Border.all(
                                  color: UColors.gray300,
                                  width: 1,
                                ),
                              ),
                              child: ref.watch(getAllEnforcerSchedStream).when(
                                    data: (schedules) {
                                      schedules.removeWhere(
                                        (element) =>
                                            element.id == widget.schedule.id,
                                      );
                                      final query = ref.watch(
                                        scheduleSearchProvider,
                                      );

                                      schedules = _searchScheds(
                                        schedules,
                                        query,
                                      );

                                      if (schedules.isEmpty &&
                                          query.isNotEmpty) {
                                        return const Center(
                                          child: Text('Schedule not found'),
                                        );
                                      }

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
                          onPressed: _onUpdateButtonTap,
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

  List<EnforcerSchedule> _searchScheds(
      List<EnforcerSchedule> list, String query) {
    if (query.isEmpty) {
      return list;
    }

    query = query.toLowerCase();

    return list
        .where((element) =>
            element.enforcerName.toString().toLowerCase().contains(query) ||
            element.shift.name.toString().toLowerCase().contains(query) ||
            element.postName.toString().toLowerCase().contains(query))
        .toList();
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
        // print(isSelected);
        // print(sched.toString());
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
