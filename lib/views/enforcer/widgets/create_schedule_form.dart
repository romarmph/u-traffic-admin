import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/views/enforcer_sched.riverpod.dart';

class CreateEnforcerSchedForm extends ConsumerStatefulWidget {
  const CreateEnforcerSchedForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateEnforcerSchedFormState();
}

class CreateEnforcerSchedFormState
    extends ConsumerState<CreateEnforcerSchedForm> {
  final _enforcerSearchController = TextEditingController();
  final _trafficPostSearchController = TextEditingController();

  @override
  void initState() {
    _enforcerSearchController.addListener(() {
      ref.read(unassignedEnforcerSearchProvider.notifier).state =
          _enforcerSearchController.text;
    });
    _trafficPostSearchController.addListener(() {
      ref.read(unassignedTrafficPostSearchProvider.notifier).state =
          _trafficPostSearchController.text;
    });
    super.initState();
  }

  Future<bool> isFormVali() async {
    final selectedEnforcer = ref.watch(selectedEnforcerProvider);
    final selectedTrafficPost = ref.watch(selectedTrafficPostProvider);
    final selectedShift = ref.watch(selectedShiftProvider);

    if (selectedEnforcer == null) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please select an enforcer.',
      );
      return false;
    }

    if (selectedShift == 'night') {
      return true;
    }

    if (selectedTrafficPost == null) {
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please select a traffic post.',
      );
      return false;
    }

    return true;
  }

  void _onCreateButtonTap() async {
    final isValid = await isFormVali();

    if (!isValid) {
      return;
    }

    final enforcer = ref.watch(selectedEnforcerProvider);
    final currentAdmin = ref.read(currentAdminProvider);
    final post = ref.watch(selectedTrafficPostProvider);

    final EnforcerSchedule enforcerSchedule = EnforcerSchedule(
      shift: ref.watch(selectedShiftProvider).toShiftPeriod,
      enforcerId: enforcer!.id!,
      enforcerName:
          '${enforcer.firstName} ${enforcer.middleName} ${enforcer.lastName}',
      postId: post != null ? post.id! : '',
      postName: post != null ? post.name : '',
      createdBy: currentAdmin.id!,
      createdAt: Timestamp.now(),
    );

    try {
      EnforcerScheduleDatabse.instance.addEnforcerSched(
        enforcerSchedule,
      );
      await QuickAlert.show(
        context: navigatorKey.currentContext!,
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
                        const Text('Select Shift'),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StatusTypeDropDown(
                            value: ref.watch(selectedShiftProvider),
                            onChanged: (value) {
                              ref.read(selectedShiftProvider.notifier).state =
                                  value!;
                              if (value == 'night') {
                                ref
                                    .read(selectedTrafficPostProvider.notifier)
                                    .state = null;
                              }
                            },
                            statusList: const [
                              'morning',
                              'afternoon',
                              'night',
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: USpace.space16,
                        ),
                        const SizedBox(
                          height: USpace.space16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
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
                                    flex: 4,
                                    child: TextField(
                                      controller: _enforcerSearchController,
                                      decoration: InputDecoration(
                                        hintText: 'Search Enforcer',
                                        prefixIcon:
                                            const Icon(Icons.search_rounded),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            USpace.space8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: USpace.space16,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      'Assign Traffic Post',
                                      style: const UTextStyle()
                                          .textlgfontmedium
                                          .copyWith(
                                            color: UColors.gray500,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Visibility(
                                      visible:
                                          ref.watch(selectedShiftProvider) !=
                                              'night',
                                      child: TextField(
                                        controller:
                                            _trafficPostSearchController,
                                        decoration: InputDecoration(
                                          hintText: 'Search Traffic post',
                                          prefixIcon:
                                              const Icon(Icons.search_rounded),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              USpace.space8,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                    borderRadius: BorderRadius.circular(
                                      USpace.space12,
                                    ),
                                    color: UColors.white,
                                    border: Border.all(
                                      color: UColors.gray200,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  ),
                                  child: const AssignableEnforcerListView(),
                                ),
                              ),
                              const SizedBox(
                                width: USpace.space16,
                              ),
                              Expanded(
                                child: Container(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      USpace.space12,
                                    ),
                                    color: UColors.white,
                                    border: Border.all(
                                      color: UColors.gray200,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  ),
                                  child: const AssignableTrafficPostListView(),
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
}

class AssignableEnforcerListView extends ConsumerWidget {
  const AssignableEnforcerListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(availableEnforcerStreamProvider).when(
          data: (data) {
            final query = ref.watch(unassignedEnforcerSearchProvider);

            data = _searchEnforcer(data, query);

            if (data.isEmpty && query.isNotEmpty) {
              return const Center(
                child: Text('Enforcer not found'),
              );
            }

            if (data.isEmpty && query.isEmpty) {
              return const Center(
                child: Text('No available enforcer'),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Enforcer enforcer = data[index];
                bool isSelected = ref.watch(selectedEnforcerProvider) != null
                    ? ref.watch(selectedEnforcerProvider)!.id == enforcer.id
                    : false;
                final String name =
                    '${enforcer.firstName} ${enforcer.middleName} ${enforcer.lastName}';
                return EnforcerSelectionTile(
                  isSelected: isSelected,
                  onChanged: (value) {
                    if (value!) {
                      ref.read(selectedEnforcerProvider.notifier).state =
                          enforcer;
                    } else {
                      ref.read(selectedEnforcerProvider.notifier).state = null;
                    }
                  },
                  name: name,
                  employeeNumber: enforcer.employeeNumber,
                  photoUrl: enforcer.photoUrl,
                );
              },
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
        );
  }

  List<Enforcer> _searchEnforcer(
    List<Enforcer> enforcers,
    String query,
  ) {
    if (query.isEmpty) {
      return enforcers;
    }

    return enforcers.where((element) {
      return element.firstName.toLowerCase().contains(query.toLowerCase()) ||
          element.middleName.toLowerCase().contains(query.toLowerCase()) ||
          element.lastName.toLowerCase().contains(query.toLowerCase()) ||
          element.employeeNumber.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

class AssignableTrafficPostListView extends ConsumerWidget {
  const AssignableTrafficPostListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllTrafficPostProvider).when(
          data: (data) {
            final query = ref.watch(unassignedTrafficPostSearchProvider);

            data = _searchPost(data, query);

            final schedules = ref.watch(enforcerSchedProvider);

            data = data
                .where((post) => !schedules.any(
                      (sched) =>
                          sched.postId == post.id &&
                          sched.shift ==
                              ref.watch(selectedShiftProvider).toShiftPeriod,
                    ))
                .toList();

            if (data.isEmpty && query.isNotEmpty) {
              return const Center(
                child: Text('Traffic post not found'),
              );
            }

            if (data.isEmpty && query.isEmpty) {
              return const Center(
                child: Text('No available traffic post'),
              );
            }

            if (ref.watch(selectedShiftProvider) == 'night') {
              return const Center(
                child: Text('Traffic post is not available on night shift'),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final TrafficPost post = data[index];
                bool isSelected = ref.watch(selectedTrafficPostProvider) != null
                    ? ref.watch(selectedTrafficPostProvider)!.id == post.id
                    : false;
                return TrafficPostSelectionTile(
                  enabled: ref.watch(selectedShiftProvider) != 'night',
                  isSelected: isSelected,
                  onChanged: (value) {
                    if (value!) {
                      ref.read(selectedTrafficPostProvider.notifier).state =
                          post;
                    } else {
                      ref.read(selectedTrafficPostProvider.notifier).state =
                          null;
                    }
                  },
                  name: post.name,
                  postNumber: post.number.toString(),
                  shift: ref.watch(selectedShiftProvider),
                );
              },
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
        );
  }

  List<TrafficPost> _searchPost(
    List<TrafficPost> posts,
    String query,
  ) {
    if (query.isEmpty) {
      return posts;
    }

    return posts.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase()) ||
          element.number.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
