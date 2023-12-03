import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerSchedulePage extends ConsumerStatefulWidget {
  const EnforcerSchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnforcerSchedulePageState();
}

class _EnforcerSchedulePageState extends ConsumerState<EnforcerSchedulePage> {
  final _searchControler = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
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
                            child: const Text('Add Enforcer Schedule'),
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
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space12),
                        ),
                        child: ref.watch(getAllEnforcerSchedStream).when(
                              data: (data) {
                                final query = ref.watch(scheduleSearchProvider);
                                final shift = ref.watch(shiftDropdownProvider);

                                if (shift != 'All') {
                                  data = data
                                      .where((element) =>
                                          element.shift.name.toLowerCase() ==
                                          shift.toLowerCase())
                                      .toList();
                                }

                                if (query.isNotEmpty) {
                                  data = _searchSchedule(data, query);
                                }

                                return DataGridContainer(
                                  height: constraints.maxHeight -
                                      60 -
                                      appBarHeight -
                                      100 -
                                      16,
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
                                  child: Text('Error'),
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<EnforcerSchedule> _searchSchedule(
    List<EnforcerSchedule> data,
    String query,
  ) {
    return data.where((element) {
      return element.enforcerName.toLowerCase().contains(query.toLowerCase()) ||
          element.postName.toLowerCase().contains(query.toLowerCase()) ||
          element.shift.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
