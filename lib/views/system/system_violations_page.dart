import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemPage extends ConsumerStatefulWidget {
  const SystemPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SystemPageState();
}

class _SystemPageState extends ConsumerState<SystemPage> {
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
                const SystemMenu(
                  screen: 'violations',
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
                      child: ref.watch(violationsStreamProvider).when(
                        data: (data) {
                          final query =
                              ref.watch(vehicleTypeSearchQueryProvider);
                          return DataGridContainer(
                            constraints: constraints,
                            source: ViolationsDataGridSource(
                              _searchType(data, query),
                            ),
                            gridColumns: violationColumns,
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

  List<Violation> _searchType(List<Violation> types, String query) {
    if (query.isEmpty) {
      return types;
    }

    return types.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
