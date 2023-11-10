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
  final _searchController = TextEditingController();

  bool _isNotEmpty = false;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
      _searchController.text = '';
    });
    _searchController.addListener(() {
      setState(() {
        _isNotEmpty = _searchController.text.isNotEmpty;
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
                          SizedBox(
                            width: 400,
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                switch (_currentIndex) {
                                  case 0:
                                    ref
                                        .read(postSearchQueryProvider.notifier)
                                        .update((state) => value);
                                    break;
                                  case 1:
                                    ref
                                        .read(violationSearchQueryProvider
                                            .notifier)
                                        .update((state) => value);
                                    break;
                                  default:
                                    ref
                                        .read(vehicleTypeSearchQueryProvider
                                            .notifier)
                                        .update((state) => value);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: UColors.gray300,
                                ),
                                suffixIcon: Visibility(
                                  visible: _isNotEmpty,
                                  child: IconButton(
                                    onPressed: () {
                                      switch (_currentIndex) {
                                        case 0:
                                          ref
                                              .read(postSearchQueryProvider
                                                  .notifier)
                                              .update((state) => '');
                                          _searchController.text = '';
                                          break;
                                        case 1:
                                          ref
                                              .read(violationSearchQueryProvider
                                                  .notifier)
                                              .update((state) => '');
                                          _searchController.text = '';
                                          break;
                                        case 2:
                                          ref
                                              .read(
                                                  vehicleTypeSearchQueryProvider
                                                      .notifier)
                                              .update((state) => '');
                                          _searchController.text = '';
                                      }
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
                          const SizedBox(
                            width: 16,
                          ),
                          // Add button
                          SystemAddButon(
                            currentTabIndex: _currentIndex,
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
                          PostsTab(
                            constraints: constraints,
                          ),
                          ViolationsTab(
                            constraints: constraints,
                          ),
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

class SystemAddButon extends ConsumerWidget {
  const SystemAddButon({
    super.key,
    required this.currentTabIndex,
  });

  final int currentTabIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UElevatedButton(
      onPressed: () async {},
      child: Text(
        currentTabIndex == 0
            ? "Create New Post"
            : currentTabIndex == 1
                ? "Create New Violation"
                : "Create New Vehicle Type",
      ),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return const Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Post name',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Post location',
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCreateViolationtDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return const Column(
          children: [],
        );
      },
    );
  }

  void _showCreateVehicleTypeDialog() {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) {
        return const Column(
          children: [],
        );
      },
    );
  }
}
