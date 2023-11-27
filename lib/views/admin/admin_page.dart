import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/admin_data_grid_source.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.adminStaffs,
      appBar: AppBar(
        title: const Text("Admin Staffs"),
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
                          Visibility(
                            visible: false,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 48,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: UColors.red200,
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                  border: Border.all(
                                    color: UColors.red300,
                                    width: 1,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.warning_rounded,
                                      color: UColors.red500,
                                    ),
                                    Text(
                                      "Warning!",
                                      style: TextStyle(
                                        color: UColors.red500,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'View',
                                      style: TextStyle(
                                        color: UColors.red500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          StatusTypeDropDown(
                            value: ref.watch(adminStatusQueryProvider),
                            onChanged: (value) {
                              ref
                                  .read(adminStatusQueryProvider.notifier)
                                  .state = value!;
                            },
                            statusList: const [
                              'all',
                              'active',
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
                              onChanged: (value) {
                                ref
                                    .read(adminSearchQueryProvider.notifier)
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
                                  visible: true,
                                  child: IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              adminSearchQueryProvider.notifier)
                                          .state = '';
                                      _searchController.clear();
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
                            onPressed: () {},
                            child: const Text('Add Admin'),
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
                  child: ref.watch(getAllAdminStream).when(
                        data: (data) {
                          final query = ref.watch(adminSearchQueryProvider);
                          final status = ref.watch(adminStatusQueryProvider);

                          if (status != 'all') {
                            data = data.where((enforcer) {
                              return enforcer.status.name == status;
                            }).toList();
                          }

                          data = _searchAdmin(data, query);
                          if (status != 'all') {
                            data = data.where((enforcer) {
                              return enforcer.status.name == status;
                            }).toList();
                          }
                          return DataGridContainer(
                            source: AdminDataGridSource(
                              data,
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

  List<Admin> _searchAdmin(List<Admin> list, String query) {
    return list.where((admin) {
      return admin.employeeNo.toLowerCase().contains(query.toLowerCase()) ||
          admin.email.toLowerCase().contains(query.toLowerCase()) ||
          admin.firstName.toLowerCase().contains(query.toLowerCase()) ||
          admin.middleName.toLowerCase().contains(query.toLowerCase()) ||
          admin.lastName.toLowerCase().contains(query.toLowerCase()) ||
          admin.suffix.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
