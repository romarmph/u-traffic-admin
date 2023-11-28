import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/complaints_data_grid_source.dart';
import 'package:u_traffic_admin/riverpod/database/complains_database_providers.dart';

final complaintSearchQueryProvider = StateProvider<String>((ref) {
  return "";
});

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
                      const Spacer(),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          onChanged: (value) {
                            ref
                                .read(complaintSearchQueryProvider.notifier)
                                .state = value;
                          },
                          decoration: InputDecoration(
                            hintText: "Search Complaint",
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: Visibility(
                              visible: _searchController.text.isNotEmpty,
                              child: IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  ref
                                      .read(
                                          complaintSearchQueryProvider.notifier)
                                      .state = "";
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ),
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

                            final query =
                                ref.watch(complaintSearchQueryProvider);

                            if (query.isNotEmpty) {
                              complaints = complaints
                                  .where((element) =>
                                      element.title
                                          .toLowerCase()
                                          .contains(query.toLowerCase()) ||
                                      element.description
                                          .toLowerCase()
                                          .contains(query.toLowerCase()))
                                  .toList();
                            }

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
                            return const Center(
                              child: Text("Error Fetching Complaints"),
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
