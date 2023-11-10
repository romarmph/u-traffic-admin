import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/columns/violation_grid_columns.dart';
import 'package:u_traffic_admin/datagrids/violation_data_grid_source.dart';

class ViolationsTab extends ConsumerStatefulWidget {
  const ViolationsTab({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViolationsTabState();
}

class _ViolationsTabState extends ConsumerState<ViolationsTab> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(violationsStreamProvider).when(
      data: (data) {
        final query = ref.watch(violationSearchQueryProvider);

        return DataGridContainer(
          constraints: widget.constraints,
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

  List<Violation> _searchType(List<Violation> types, String query) {
    if (query.isEmpty) {
      return types;
    }

    return types.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
