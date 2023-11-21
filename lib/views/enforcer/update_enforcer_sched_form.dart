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
                        Expanded(
                          child: Visibility(
                            visible: schedEditMode == 'reassign',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                              visible: ref.watch(
                                                      selectedShiftProvider) !=
                                                  'night',
                                              child: TextField(
                                                controller:
                                                    _trafficPostSearchController,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Search Traffic post',
                                                  prefixIcon: const Icon(
                                                      Icons.search_rounded),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                              controller:
                                                  _enforcerSearchController,
                                              decoration: InputDecoration(
                                                hintText: 'Search Enforcer',
                                                prefixIcon: const Icon(
                                                    Icons.search_rounded),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                              strokeAlign:
                                                  BorderSide.strokeAlignInside,
                                            ),
                                          ),
                                          child:
                                              const AssignableTrafficPostListView(),
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
                                              strokeAlign:
                                                  BorderSide.strokeAlignInside,
                                            ),
                                          ),
                                          child:
                                              const AssignableEnforcerListView(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
