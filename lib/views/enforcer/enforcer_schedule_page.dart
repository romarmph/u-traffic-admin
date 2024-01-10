import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:calendar_view/calendar_view.dart';

class EnforcerSchedulePage extends ConsumerStatefulWidget {
  const EnforcerSchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnforcerSchedulePageState();
}

class _EnforcerSchedulePageState extends ConsumerState<EnforcerSchedulePage> {
  final _calendarKey = GlobalKey<MonthViewState>();
  final _searchControler = TextEditingController();
  final _calendarController = EventController();
  @override
  initState() {
    super.initState();
  }

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
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          StatusTypeDropDown(
                            statusList: const [
                              'All',
                              'Morning',
                              'Afternoon',
                              'Night',
                            ],
                            onChanged: (value) {
                              ref.read(shiftDropdownProvider.notifier).state =
                                  value!;
                            },
                            value: ref.watch(shiftDropdownProvider),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _searchControler,
                              onChanged: (value) {
                                ref
                                    .read(scheduleSearchProvider.notifier)
                                    .state = value;
                              },
                              decoration: InputDecoration(
                                hintText: "Quick Search",
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(USpace.space8),
                                ),
                                suffixIcon: Visibility(
                                  visible: _searchControler.text.isNotEmpty,
                                  child: IconButton(
                                    onPressed: () {
                                      _searchControler.clear();
                                      ref
                                          .read(scheduleSearchProvider.notifier)
                                          .state = '';
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          UElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return const CreateEnforcerSchedForm();
                                  },
                                ),
                              );
                            },
                            child: const Text('Create Schedule'),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space12),
                      ),
                      child: MonthView(
                        key: _calendarKey,
                        controller: _calendarController,
                        cellAspectRatio: 2.5 / 1,
                        cellBuilder: (date, event, isToday, isInMonth) {
                          return ref
                              .watch(hasScheduleProvider(date.toTimestamp))
                              .when(
                            data: (hasSchedule) {
                              if (hasSchedule) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: hasSchedule
                                        ? UColors.orange100
                                        : UColors.white,
                                    borderRadius: BorderRadius.circular(
                                      USpace.space8,
                                    ),
                                    border: Border.all(
                                      color: hasSchedule
                                          ? UColors.orange300
                                          : UColors.white,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          date.day.toString(),
                                          style: TextStyle(
                                            color: hasSchedule
                                                ? UColors.orange300
                                                : UColors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Icon(
                                          Icons.check_circle,
                                          color: UColors.orange300,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return Container(
                                decoration: BoxDecoration(
                                  color: hasSchedule
                                      ? UColors.orange100
                                      : UColors.white,
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                  border: Border.all(
                                    color: hasSchedule
                                        ? UColors.orange300
                                        : UColors.white,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      color: hasSchedule
                                          ? UColors.orange300
                                          : UColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            error: (error, stackTrace) {
                              return Center(
                                child: Text(
                                  error.toString(),
                                ),
                              );
                            },
                          );
                        },
                        onCellTap: (events, date) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ShowScheduleModal(
                                  day: date.toTimestamp,
                                ),
                              );
                            },
                          );
                        },
                        headerBuilder: (date) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _calendarKey.currentState!.previousPage();
                                },
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    date.toMonthYear,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _calendarKey.currentState!.nextPage();
                                },
                                icon: const Icon(Icons.arrow_forward_ios),
                              ),
                            ],
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

class ShowScheduleModal extends ConsumerWidget {
  const ShowScheduleModal({
    super.key,
    required this.day,
  });

  final Timestamp day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 1200,
      height: 800,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${DateFormat('MMMM dd, yyyy').format(day.toDate())} Schedule',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ref.watch(getAllSchedulesByDay(day)).when(
                    data: (schedules) {
                      return ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          if (schedules[index].shift != ShiftPeriod.morning) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            padding: const EdgeInsets.all(4),
                            color: UColors.orange100,
                            child: ListTile(
                              tileColor: UColors.orange100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  USpace.space8,
                                ),
                                side: const BorderSide(
                                  color: UColors.orange300,
                                ),
                              ),
                              title: Text(
                                schedules[index].enforcerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                schedules[index].shift.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ref.watch(getAllSchedulesByDay(day)).when(
                    data: (schedules) {
                      return ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          if (schedules[index].shift != ShiftPeriod.afternoon) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            padding: const EdgeInsets.all(4),
                            color: UColors.blue100,
                            child: ListTile(
                              tileColor: UColors.orange100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  USpace.space8,
                                ),
                                side: const BorderSide(
                                  color: UColors.orange300,
                                ),
                              ),
                              title: Text(
                                schedules[index].enforcerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                schedules[index].shift.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ref.watch(getAllSchedulesByDay(day)).when(
                    data: (schedules) {
                      return ListView.builder(
                        itemCount: schedules.length,
                        itemBuilder: (context, index) {
                          if (schedules[index].shift != ShiftPeriod.night) {
                            return const SizedBox.shrink();
                          }

                          return Container(
                            padding: const EdgeInsets.all(4),
                            color: UColors.purple100,
                            child: ListTile(
                              tileColor: UColors.orange100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  USpace.space8,
                                ),
                                side: const BorderSide(
                                  color: UColors.orange300,
                                ),
                              ),
                              title: Text(
                                schedules[index].enforcerName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                schedules[index].shift.name.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          error.toString(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Spacer(),
              UElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final getAllSchedulesByDay = StreamProvider.autoDispose
    .family<List<EnforcerSchedule>, Timestamp>((ref, day) {
  return EnforcerScheduleDatabse.instance.getAllEnforcerScheduleByDay(day);
});

final hasScheduleProvider = FutureProvider.family<bool, Timestamp>((ref, day) {
  return EnforcerScheduleDatabse.instance.hasSchedule(day);
});
