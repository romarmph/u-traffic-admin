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
    final shift = ref.watch(selectedShiftProvider);

    if (post == null) {
      shift == 'night';
    }

    final EnforcerSchedule enforcerSchedule = EnforcerSchedule(
      shift: shift.toShiftPeriod,
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

  void disposeProvider() {
    ref.invalidate(unassignedEnforcerSearchProvider);
    ref.invalidate(unassignedTrafficPostSearchProvider);
    ref.invalidate(selectedEnforcerProvider);
    ref.invalidate(selectedTrafficPostProvider);
    ref.invalidate(selectedShiftProvider);
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
                            const SizedBox(
                              width: USpace.space16,
                            ),
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
                                  child: const AssignableTrafficPostListView(),
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
                                  child: const AssignableEnforcerListView(),
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
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



