import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/datagrids/traffic_post_data_grid_source.dart';

class PostsTab extends ConsumerStatefulWidget {
  const PostsTab({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostsTabState();
}

class _PostsTabState extends ConsumerState<PostsTab> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getAllTrafficPostProvider).when(
      data: (data) {
        final query = ref.watch(vehicleTypeSearchQueryProvider);
        return DataGridContainer(
          constraints: widget.constraints,
          source: TrafficPostDataGridSource(
            _searchType(data, query),
          ),
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
