import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class SystemEnforcerSchedulePage extends ConsumerStatefulWidget {
  const SystemEnforcerSchedulePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SystemEnforcerSchedulePageState();
}

class _SystemEnforcerSchedulePageState
    extends ConsumerState<SystemEnforcerSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      route: Routes.systemEnforcerSchedule,
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
                  route: Routes.systemEnforcerSchedule,
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
                      child: ref.watch(vehicleTypesStreamProvider).when(
                        data: (data) {
                          final query =
                              ref.watch(vehicleTypeSearchQueryProvider);
                          return DataGridContainer(
                            constraints: constraints,
                            source: VehicleDataGridSource(
                              _searchType(data, query),
                              ref,
                            ),
                            gridColumns: vehicleTypeColumns,
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

  List<VehicleType> _searchType(List<VehicleType> types, String query) {
    if (query.isEmpty) {
      return types;
    }

    return types.where((element) {
      return element.typeName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}