import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerPage extends ConsumerStatefulWidget {
  const EnforcerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnforcerPageState();
}

class _EnforcerPageState extends ConsumerState<EnforcerPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.enforcers,
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
                          const Spacer(),
                          StatusTypeDropDown(
                            value: ref.watch(enforcerStatusQueryProvider),
                            onChanged: (value) {
                              ref
                                  .read(enforcerStatusQueryProvider.notifier)
                                  .state = value!;
                            },
                            statusList: const [
                              'all',
                              'active',
                              'onduty',
                              'offduty',
                              'onleave',
                              'suspended',
                              'terminated',
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            width: 400,
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                ref
                                    .read(enforcerSearchQueryProvider.notifier)
                                    .state = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: UColors.gray300,
                                ),
                                suffixIcon: Visibility(
                                  visible: _searchController.text.isNotEmpty,
                                  child: IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      ref
                                          .read(enforcerSearchQueryProvider
                                              .notifier)
                                          .state = '';
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
                          UElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                Routes.enforcersCreate,
                              );
                            },
                            child: const Text('Add Enforcer'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: ref.watch(getAllEnforcerStream).when(
                        data: (data) {
                          final query = ref.watch(enforcerSearchQueryProvider);
                          final status = ref.watch(enforcerStatusQueryProvider);
                          if (status != 'all') {
                            data = data.where((enforcer) {
                              return enforcer.status.name == status;
                            }).toList();
                          }
                          data = _searchEnforcer(data, query);
                          return DataGridContainer(
                            source: EnforcerDataGridSource(
                              data,
                              ref,
                            ),
                            dataCount: data.length,
                            gridColumns: enforcerGridColumns,
                            constraints: constraints,
                          );
                        },
                        error: (error, stackTrace) {
                          return const Center(
                            child: Text('Error fetching tickets'),
                          );
                        },
                        loading: () => SizedBox(
                          height: constraints.maxHeight - 100 - 64,
                          child: const Center(
                            child: CircularProgressIndicator(),
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

  List<Enforcer> _searchEnforcer(List<Enforcer> list, String query) {
    if (query.isEmpty) {
      return list;
    }

    return list.where((enforcer) {
      query = query.toLowerCase();
      return enforcer.firstName.toLowerCase().contains(query) ||
          enforcer.middleName.toLowerCase().contains(query) ||
          enforcer.lastName.toLowerCase().contains(query) ||
          enforcer.employeeNumber.toLowerCase().contains(query) ||
          enforcer.email.toLowerCase().contains(query) ||
          enforcer.createdAt.toAmericanDate.toLowerCase().contains(query);
    }).toList();
  }
}
