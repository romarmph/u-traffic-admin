import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerPage extends ConsumerStatefulWidget {
  const EnforcerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnforcerPageState();
}

class _EnforcerPageState extends ConsumerState<EnforcerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.enforcersView,
      appBar: AppBar(
        title: const Text("Enforcers"),
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
                        children: [
                          Expanded(
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: _tabController,
                              tabs: const [
                                Tab(
                                  text: 'Morning Shift',
                                ),
                                Tab(
                                  text: 'Afternoon Shift',
                                ),
                                Tab(
                                  text: 'Night Shift',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          SizedBox(
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
                          const SizedBox(
                            width: 16,
                          ),
                          UElevatedButton(
                            onPressed: () {},
                            child: const Text('Add Enforcer'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: constraints.maxHeight - 100 - 32,
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(USpace.space12),
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Column(),
                        Column(),
                        Column(),
                      ],
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
