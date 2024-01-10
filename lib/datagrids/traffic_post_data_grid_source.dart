import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/system/add_forms/traffic_post_create_form.dart';

class TrafficPostDataGridSource extends DataGridSource {
  TrafficPostDataGridSource(
    this.trafficPost,
  ) {
    _buildDataGridRows();
  }

  List<TrafficPost> trafficPost = [];

  List<DataGridRow> _trafficRows = [];

  @override
  List<DataGridRow> get rows => _trafficRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        if (cell.columnName == TrafficPostFields.createdAt ||
            cell.columnName == TrafficPostFields.updatedAt) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              cell.value.toString().toDateTime.toTimestamp.toAmericanDate,
            ),
          );
        }

        if (cell.columnName == TrafficPostFields.action) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(USpace.space8),
                  ),
                  side: const BorderSide(
                    color: UColors.blue400,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: navigatorKey.currentContext!,
                    builder: (context) {
                      return Dialog(
                        child: ViewTrafficPost(
                          postId: cell.value.toString(),
                        ),
                      );
                    },
                  );
                },
                child: const Text('View'),
              ),
              const SizedBox(
                width: 12,
              ),
              DeleteEnforcerSchedBtn(
                postId: cell.value.toString(),
              ),
            ],
          );
        }

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            cell.value.toString(),
          ),
        );
      }).toList(),
    );
  }

  void _buildDataGridRows() {
    _trafficRows = trafficPost.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(
          columnName: TrafficPostFields.number,
          value: dataGridRow.number,
        ),
        DataGridCell<String>(
          columnName: TrafficPostFields.name,
          value: dataGridRow.name,
        ),
        DataGridCell<String>(
          columnName: TrafficPostFields.location,
          value: dataGridRow.location.address,
        ),
        DataGridCell<DateTime>(
          columnName: TrafficPostFields.createdAt,
          value: dataGridRow.createdAt.toDate(),
        ),
        DataGridCell<String>(
          columnName: TrafficPostFields.action,
          value: dataGridRow.id,
        ),
      ]);
    }).toList();
  }
}

class DeleteEnforcerSchedBtn extends ConsumerWidget {
  const DeleteEnforcerSchedBtn({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(USpace.space8),
        ),
        foregroundColor: UColors.red400,
        side: const BorderSide(
          color: UColors.red400,
        ),
      ),
      onPressed: () async {
        final result = await QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Delete Traffic Post',
          text:
              'Deleting this traffic post will also delete all the enforcer schedules assigned to this post. Are you sure you want to delete this traffic post?',
          onConfirmBtnTap: () {
            Navigator.of(context).pop(true);
          },
          showCancelBtn: true,
        );

        if (result != true) {
          return;
        }

        try {
          await TrafficPostDatabase.instance.deletePost(postId);
        } catch (e) {
          await QuickAlert.show(
            context: navigatorKey.currentContext!,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Error deleting traffic post.',
          );
          return;
        }
      },
      child: const Text('Delete'),
    );
  }
}

class ViewTrafficPost extends ConsumerWidget {
  const ViewTrafficPost({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          USpace.space12,
        ),
        color: Colors.white,
      ),
      child: ref.watch(trafficPostProviderById(postId)).when(data: (post) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Traffic Post Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            PreviewListTile(
              title: post.number.toString(),
              subtitle: 'Traffic Post Number',
            ),
            PreviewListTile(
              title: post.name,
              subtitle: 'Traffic Post Name',
            ),
            const SizedBox(
              height: 12,
            ),
            PreviewListTile(
              title: post.location.address,
              subtitle: 'Traffic Post Location',
            ),
            const SizedBox(
              height: 12,
            ),
            ref.watch(getAdminByIdStream(post.createdBy)).when(data: (admin) {
              return PreviewListTile(
                title: '${admin.firstName} ${admin.lastName}',
                subtitle: post.createdAt.toDate().toTimestamp.toAmericanDate,
              );
            }, error: (error, stackTrace) {
              return const Center(
                child: Text(
                  'Error loading admin.',
                ),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
            post.updatedBy.isNotEmpty
                ? ref.watch(getAdminByIdStream(post.updatedBy)).when(
                    data: (admin) {
                      return PreviewListTile(
                        title: '${admin.firstName} ${admin.lastName}',
                        subtitle:
                            post.updatedAt!.toDate().toTimestamp.toAmericanDate,
                      );
                    },
                    error: (error, stackTrace) {
                      return const Center(
                        child: Text(
                          'Error loading admin.',
                        ),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                : const SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(
                  width: 12,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return Dialog(
                    //       child: CreateTrafficPostFormDialog(
                    //         post: post,
                    //       ),
                    //     );
                    //   },
                    // );
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => CreateTrafficPostForm(
                          post: post,
                        ),
                      ),
                    );
                  },
                  child: const Text('Update'),
                ),
              ],
            )
          ],
        );
      }, error: (error, stackTrace) {
        return const Center(
          child: Text(
            'Error loading traffic post.',
          ),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
