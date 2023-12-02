import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemTrafficPostPage extends ConsumerStatefulWidget {
  const SystemTrafficPostPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SystemTrafficPostPageState();
}

class _SystemTrafficPostPageState extends ConsumerState<SystemTrafficPostPage> {
  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    return PageContainer(
      route: Routes.systemTrafficPosts,
      appBar: AppBar(
        title: const Text("System"),
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
                const SystemMenu(
                  route: Routes.systemTrafficPosts,
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
                      child: ref.watch(getAllTrafficPostProvider).when(
                        data: (data) {
                          final query =
                              ref.watch(vehicleTypeSearchQueryProvider);
                          return DataGridContainer(
                            constraints: constraints,
                            source: TrafficPostDataGridSource(
                              _searchType(data, query),
                            ),
                            height: constraints.maxHeight -
                                60 -
                                appBarHeight -
                                100 -
                                16,
                            gridColumns: trafficPostColumns,
                            dataCount: _searchType(data, query).length,
                          );
                        },
                        error: (error, stackTrace) {
                          return const Center(
                            child: Text(
                              'Error fetching traffic posts',
                            ),
                          );
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
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

  List<TrafficPost> _searchType(List<TrafficPost> types, String query) {
    if (query.isEmpty) {
      return types;
    }

    return types.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
