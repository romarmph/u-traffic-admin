import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemPage extends ConsumerStatefulWidget {
  const SystemPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SystemPageState();
}

class _SystemPageState extends ConsumerState<SystemPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _vehicleTypeSearchController = TextEditingController();
  final _violationSearchController = TextEditingController();
  final _postSearchController = TextEditingController();

  int _curentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _curentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.system,
      appBar: AppBar(
        title: const Text("System"),
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
                        children: [
                          SizedBox(
                            width: 400,
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: _tabController,
                              tabs: const [
                                Tab(
                                  text: 'Posts',
                                ),
                                Tab(
                                  text: 'Violations',
                                ),
                                Tab(
                                  text: 'Vehicle Types',
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: 32,
                          ),
                          // Posts search field
                          Visibility(
                            visible: _curentIndex == 0,
                            child: SizedBox(
                              width: 400,
                              child: TextField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: UColors.gray300,
                                  ),
                                  suffixIcon: Visibility(
                                    visible: true,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: UColors.gray300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Violations search field
                          Visibility(
                            visible: _curentIndex == 1,
                            child: SizedBox(
                              width: 400,
                              child: TextField(
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: UColors.gray300,
                                  ),
                                  suffixIcon: Visibility(
                                    visible: true,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: UColors.gray300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Vehicle tpyes search field
                          Visibility(
                            visible: _curentIndex == 2,
                            child: SizedBox(
                              width: 400,
                              child: TextField(
                                controller: _vehicleTypeSearchController,
                                onChanged: (value) {
                                  ref
                                      .read(vehicleTypeSearchQueryProvider
                                          .notifier)
                                      .update((state) => value);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: UColors.gray300,
                                  ),
                                  suffixIcon: Visibility(
                                    visible: ref.watch(
                                            vehicleTypeSearchQueryProvider) !=
                                        '',
                                    child: IconButton(
                                      onPressed: () {
                                        _vehicleTypeSearchController.text = '';
                                        ref
                                            .read(vehicleTypeSearchQueryProvider
                                                .notifier)
                                            .update((state) => '');
                                      },
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: UColors.gray300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: UColors.white,
                        borderRadius: BorderRadius.circular(USpace.space12),
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(),
                          Column(),
                          VehicleTypesTab(
                            constraints: constraints,
                          ),
                        ],
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
