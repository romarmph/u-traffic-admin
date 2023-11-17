import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerPage extends ConsumerStatefulWidget {
  const EnforcerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EnforcerPageState();
}

class _EnforcerPageState extends ConsumerState<EnforcerPage> {
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
                          const Spacer(),
                          StatusTypeDropDown(
                            value: 'all',
                            onChanged: (value) {},
                            statusList: const [
                              'all',
                              'morning',
                              'afternoon',
                              'night',
                            ],
                          ),
                          const SizedBox(
                            width: 16,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: ref.watch(getAllEnforcerStream).when(
                        data: (data) {
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
                          print(error);
                          print(stackTrace);
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
}
