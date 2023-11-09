import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/common/datagrid/columns/vehicle_types_grid_columns.dart';
import 'package:u_traffic_admin/views/common/datagrid/vehicle_type_data_grid_srouce.dart';

class VehicleTypesTab extends ConsumerStatefulWidget {
  const VehicleTypesTab({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VehicleTypesTabState();
}

class _VehicleTypesTabState extends ConsumerState<VehicleTypesTab> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(vehicleTypesStreamProvider).when(
      data: (data) {
        final query = ref.watch(vehicleTypeSearchQueryProvider);
        return DataGridContainer(
          constraints: widget.constraints,
          source: VehicleDataGridSource(
            _searchType(data, query),
          ),
          gridColumns: vehicleTypeColumns,
          dataCount: _searchType(data, query).length,
        );
      },
      error: (error, stackTrace) {
        return const Center(
          child: Text(
            'Error fetching vehicle types',
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
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
