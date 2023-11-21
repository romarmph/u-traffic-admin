import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class AssignableTrafficPostListView extends ConsumerWidget {
  const AssignableTrafficPostListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllTrafficPostProvider).when(
          data: (data) {
            final query = ref.watch(unassignedTrafficPostSearchProvider);

            data = _searchPost(data, query);

            final schedules = ref.watch(enforcerSchedProvider);

            data = data
                .where((post) => !schedules.any(
                      (sched) =>
                          sched.postId == post.id &&
                          sched.shift ==
                              ref.watch(selectedShiftProvider).toShiftPeriod,
                    ))
                .toList();

            if (data.isEmpty && query.isNotEmpty) {
              return const Center(
                child: Text('Traffic post not found'),
              );
            }

            if (data.isEmpty && query.isEmpty) {
              return const Center(
                child: Text('No available traffic post'),
              );
            }

            if (ref.watch(selectedShiftProvider) == 'night') {
              return const Center(
                child: Text('Traffic post is not available on night shift'),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final TrafficPost post = data[index];
                bool isSelected = ref.watch(selectedTrafficPostProvider) != null
                    ? ref.watch(selectedTrafficPostProvider)!.id == post.id
                    : false;
                return TrafficPostSelectionTile(
                  enabled: ref.watch(selectedShiftProvider) != 'night',
                  isSelected: isSelected,
                  onChanged: (value) {
                    if (value!) {
                      ref.read(selectedTrafficPostProvider.notifier).state =
                          post;
                    } else {
                      ref.read(selectedTrafficPostProvider.notifier).state =
                          null;
                    }
                  },
                  name: post.name,
                  postNumber: post.number.toString(),
                  shift: ref.watch(selectedShiftProvider),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text('Error'),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }

  List<TrafficPost> _searchPost(
    List<TrafficPost> posts,
    String query,
  ) {
    if (query.isEmpty) {
      return posts;
    }

    return posts.where((element) {
      return element.name.toLowerCase().contains(query.toLowerCase()) ||
          element.number.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
