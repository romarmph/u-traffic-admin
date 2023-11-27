import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/complaints_data_grid_source.dart';
import 'package:u_traffic_admin/riverpod/database/complains_database_providers.dart';

class ComplaintsPage extends ConsumerStatefulWidget {
  const ComplaintsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends ConsumerState<ComplaintsPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.complaints,
      appBar: AppBar(
        title: const Text("Complaints"),
        actions: const [
          CurrenAdminButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 100,
                  decoration: BoxDecoration(
                    color: UColors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _searchController,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ref.watch(getAllComplaintsProvider).when(
                          data: (complaints) {
                            complaints = complaints
                                .where(
                                    (element) => element.parentThread == null)
                                .toList();

                            return DataGridContainer(
                              gridLinesVisibility: GridLinesVisibility.none,
                              headerGridLinesVisibility:
                                  GridLinesVisibility.none,
                              constraints: constraints,
                              source: ComplaintsDataGridSource(
                                complaints,
                                ref,
                              ),
                              gridColumns: complaintGridColumn,
                              dataCount: complaints.length,
                            );
                          },
                          error: (error, stackTrace) {
                            print(error);
                            return const Center(
                              child: Text("Error"),
                            );
                          },
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
