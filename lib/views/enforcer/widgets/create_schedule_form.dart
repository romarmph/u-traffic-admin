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
  String _shiftPeriod = 'morning';
  TimePeriod startTime = TimePeriod(
    hour: 12,
    minute: 0,
    period: 'AM',
  );
  TimePeriod endTime = TimePeriod(
    hour: 12,
    minute: 0,
    period: 'AM',
  );

  void _onCreateButtonTap() async {
    final currentAdmin = ref.read(currentAdminProvider);

    if (startTime.timeDifference(endTime).inHours < 0 ||
        startTime.timeDifference(endTime).inHours < 7) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Invalid Time',
        text: 'Please check the time you entered.',
      );
      return;
    }

    final EnforcerSchedule enforcerSchedule = EnforcerSchedule(
      shift: _shiftPeriod.toShiftPeriod,
      startTime: startTime,
      endTime: endTime,
      createdBy: currentAdmin.id!,
      createdAt: Timestamp.now(),
    );
    try {
      EnforcerScheduleDatabse.instance.addEnforcerSched(
        enforcerSchedule,
      );
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Enforcer Schedule has been created.',
      );
      Navigator.pop(navigatorKey.currentContext!);
    } catch (e) {
      await QuickAlert.show(
        context: navigatorKey.currentContext!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Something went wrong. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text('Create Enforcer'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcerSchedulesCreate,
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
                          'New Schedule',
                          style: TextStyle(
                            color: UColors.gray400,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Shift'),
                                StatusTypeDropDown(
                                  value: _shiftPeriod,
                                  onChanged: (value) {
                                    setState(() {
                                      _shiftPeriod = value!;
                                    });
                                  },
                                  statusList: const [
                                    'morning',
                                    'afternoon',
                                    'night',
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: USpace.space16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Start Time'),
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: UColors.white,
                                    borderRadius:
                                        BorderRadius.circular(USpace.space8),
                                    border: Border.all(
                                      color: UColors.gray300,
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      final TimeOfDay? time =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                          hour: endTime.hour,
                                          minute: endTime.minute,
                                        ),
                                      );
                                      if (time != null) {
                                        setState(() {
                                          startTime = TimePeriod(
                                            hour: time.hourOfPeriod,
                                            minute: time.minute,
                                            period: time.period.index == 0
                                                ? 'AM'
                                                : 'PM',
                                          );
                                        });
                                      }
                                    },
                                    title: Text(
                                      '${startTime.hour.toString().padLeft(2, 0.toString())}:${startTime.minute.toString().padLeft(2, 0.toString())} ${startTime.period.toUpperCase()}',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: USpace.space16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('End Time'),
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: UColors.white,
                                    borderRadius:
                                        BorderRadius.circular(USpace.space8),
                                    border: Border.all(
                                      color: UColors.gray300,
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      final TimeOfDay? time =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                          hour: endTime.hour,
                                          minute: endTime.minute,
                                        ),
                                      );
                                      if (time != null) {
                                        setState(() {
                                          endTime = TimePeriod(
                                            hour: time.hourOfPeriod,
                                            minute: time.minute,
                                            period: time.period.index == 0
                                                ? 'AM'
                                                : 'PM',
                                          );
                                        });
                                      }
                                    },
                                    title: Text(
                                      '${endTime.hour.toString().padLeft(2, 0.toString())}:${endTime.minute.toString().padLeft(2, 0.toString())} ${endTime.period.toUpperCase()}',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: USpace.space16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Duration'),
                                Container(
                                  width: 300,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: UColors.white,
                                    borderRadius:
                                        BorderRadius.circular(USpace.space8),
                                    border: Border.all(
                                      color: UColors.gray300,
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      _getDuration(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Assign Enforcer',
                                style: const UTextStyle()
                                    .textlgfontmedium
                                    .copyWith(
                                      color: UColors.gray500,
                                    ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Assign Traffic Post',
                                style: const UTextStyle()
                                    .textlgfontmedium
                                    .copyWith(
                                      color: UColors.gray500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: USpace.space12,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    color: UColors.white,
                                    border: Border.all(
                                        color: UColors.gray200,
                                        strokeAlign:
                                            BorderSide.strokeAlignInside),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    color: UColors.white,
                                    border: Border.all(
                                        color: UColors.gray200,
                                        strokeAlign:
                                            BorderSide.strokeAlignInside),
                                  ),
                                ),
                              ),
                            ],
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
                          onPressed: () {},
                          child: const Text('Cancel'),
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
                          onPressed: _onCreateButtonTap,
                          label: const Text('Save Schedule'),
                          icon: const Icon(Icons.save_rounded),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDuration() {
    final int duration = startTime.timeDifference(endTime).inMinutes;
    final int hour = duration ~/ 60;
    final int minute = duration % 60;
    return '${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}';
  }
}
