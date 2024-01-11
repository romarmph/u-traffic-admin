import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class CreateEnforcerSchedForm extends ConsumerStatefulWidget {
  const CreateEnforcerSchedForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateEnforcerSchedFormState();
}

class CreateEnforcerSchedFormState
    extends ConsumerState<CreateEnforcerSchedForm> {
  DateTime? _selectedDate;

  void disposeProvider() {
    ref.invalidate(unassignedEnforcerSearchProvider);
    ref.invalidate(unassignedTrafficPostSearchProvider);
    ref.invalidate(selectedEnforcerProvider);
    ref.invalidate(selectedTrafficPostProvider);
    ref.invalidate(selectedShiftProvider);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text('Create Enforcer'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcerSchedulesCreate,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: UColors.white,
            borderRadius: BorderRadius.circular(USpace.space16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Schedule Day'),
                          UElevatedButton(
                            onPressed: () async {
                              final scheds = ref.watch(tempSchedule);

                              if (scheds.isEmpty) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  text: 'Please assign an enforcer first',
                                );
                                return;
                              }

                              for (final sched in scheds) {
                                await EnforcerScheduleDatabse.instance
                                    .addEnforcerSched(
                                  sched,
                                );
                              }

                              await QuickAlert.show(
                                context: navigatorKey.currentContext!,
                                type: QuickAlertType.success,
                                text: 'Schedule created successfully',
                              );

                              Navigator.of(navigatorKey.currentContext!)
                                  .pushNamed(
                                Routes.enforcerSchedules,
                              );
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: 300,
                        child: ListTile(
                          onTap: () async {
                            final DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              setState(() {
                                _selectedDate = date;
                              });
                            }
                          },
                          title: Text(
                            _selectedDate != null
                                ? DateFormat.yMMMMd().format(_selectedDate!)
                                : 'Select Date',
                          ),
                          subtitle: const Text('Tap to select date'),
                        ),
                      ),
                      const Divider(),
                      const Text('Enforcers'),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: SchedList(
                                shift: ShiftPeriod.morning,
                                onPressed: () {
                                  if (_selectedDate == null) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: 'Please select a date first',
                                    );
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Assign Enforcer'),
                                        content: AssignEnforcerModal(
                                          day: _selectedDate!.toTimestamp,
                                          shift: ShiftPeriod.morning,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            VerticalDivider(),
                            Expanded(
                              child: SchedList(
                                shift: ShiftPeriod.afternoon,
                                onPressed: () {
                                  if (_selectedDate == null) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: 'Please select a date first',
                                    );
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Assign Enforcer'),
                                        content: AssignEnforcerModal(
                                          day: _selectedDate!.toTimestamp,
                                          shift: ShiftPeriod.afternoon,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            VerticalDivider(),
                            Expanded(
                              child: SchedList(
                                shift: ShiftPeriod.night,
                                onPressed: () {
                                  if (_selectedDate == null) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.error,
                                      text: 'Please select a date first',
                                    );
                                    return;
                                  }

                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Assign Enforcer'),
                                        content: AssignEnforcerModal(
                                          day: _selectedDate!.toTimestamp,
                                          shift: ShiftPeriod.night,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SchedList extends ConsumerWidget {
  const SchedList({
    super.key,
    required this.shift,
    required this.onPressed,
  });

  final ShiftPeriod shift;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<EnforcerSchedule> schedules = ref.watch(tempSchedule);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(shift.name.toUpperCase()),
            FilledButton(
              onPressed: onPressed,
              child: const Text('Assign Enforcer'),
            ),
          ],
        ),
        Expanded(
          child: ListView(
              children: schedules.where((arg) => arg.shift == shift).map((e) {
            return ListTile(
              contentPadding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(USpace.space16),
                side: const BorderSide(
                  color: UColors.gray200,
                ),
              ),
              title: Text("Enforcer: ${e.enforcerName}"),
              subtitle: Text("Post: ${e.postName}"),
              trailing: IconButton(
                onPressed: () {
                  schedules.remove(e);
                  ref.read(tempSchedule.notifier).state = [...schedules];
                },
                icon: const Icon(Icons.delete),
              ),
            );
          }).toList()),
        ),
      ],
    );
  }
}

class AssignEnforcerModal extends ConsumerStatefulWidget {
  const AssignEnforcerModal({
    super.key,
    required this.day,
    required this.shift,
  });

  final Timestamp day;
  final ShiftPeriod shift;

  @override
  ConsumerState<AssignEnforcerModal> createState() =>
      _AssignEnforcerModalState();
}

class _AssignEnforcerModalState extends ConsumerState<AssignEnforcerModal> {
  Enforcer? selectedEnforcer;
  TrafficPost? selectedPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space16),
      ),
      width: 900,
      height: 800,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ref.watch(availableEnforcers(widget.day)).when(
                        data: (data) {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final Enforcer enforcer = data[index];

                              if (ref.watch(tempSchedule).any((element) =>
                                  element.enforcerId == enforcer.id)) {
                                return const SizedBox();
                              }

                              return RadioListTile(
                                value: enforcer,
                                groupValue: selectedEnforcer,
                                onChanged: (value) {
                                  setState(() {
                                    selectedEnforcer = value as Enforcer;
                                  });
                                },
                                title: Text(
                                  '${enforcer.firstName} ${enforcer.lastName}',
                                ),
                              );
                            },
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (e, s) {
                          return const Center(
                            child: Text('Error'),
                          );
                        },
                      ),
                ),
                Expanded(
                  child: ref.watch(availablePosts(widget.day)).when(
                        data: (data) {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final TrafficPost post = data[index];

                              if (ref.watch(tempSchedule).any(
                                  (element) => element.postId == post.id)) {
                                return const SizedBox();
                              }
                              return RadioListTile(
                                value: post,
                                groupValue: selectedPost,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPost = value as TrafficPost;
                                  });
                                },
                                title: Text(
                                  post.name,
                                ),
                              );
                            },
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (e, s) {
                          return const Center(
                            child: Text('Error'),
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UElevatedButton(
                onPressed: () {
                  if (selectedEnforcer == null || selectedPost == null) {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      text: 'Please select an enforcer and a post',
                    );
                    return;
                  }

                  final EnforcerSchedule schedule = EnforcerSchedule(
                    enforcerId: selectedEnforcer!.id!,
                    enforcerName:
                        '${selectedEnforcer!.firstName} ${selectedEnforcer!.lastName}',
                    postId: selectedPost!.id!,
                    postName: selectedPost!.name,
                    shift: widget.shift,
                    scheduleDay: widget.day,
                    createdBy: ref.read(currentAdminProvider).id!,
                    createdAt: DateTime.now().toTimestamp,
                  );

                  ref.read(tempSchedule.notifier).state = [
                    ...ref.watch(tempSchedule),
                    schedule,
                  ];

                  Navigator.pop(context);
                },
                child: const Text('Assign'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final availableEnforcers =
    StreamProvider.family<List<Enforcer>, Timestamp>((ref, day) {
  return EnforcerScheduleDatabse.instance.getAvailableEnforcersStream(day);
});

final availablePosts =
    StreamProvider.family<List<TrafficPost>, Timestamp>((ref, day) {
  return EnforcerScheduleDatabse.instance.getAvailableTrafficPostsStream(day);
});

final tempSchedule = StateProvider<List<EnforcerSchedule>>((ref) {
  return [];
});
