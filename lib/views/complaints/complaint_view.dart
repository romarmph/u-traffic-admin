import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/database/complains_database_providers.dart';

class ComplaintViewPage extends ConsumerWidget {
  const ComplaintViewPage({
    super.key,
    required this.complaint,
  });

  final String complaint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: UColors.white,
                borderRadius: BorderRadius.circular(USpace.space8),
              ),
              padding: const EdgeInsets.all(16),
              child: ref.watch(getComplaintByIdProvider(complaint)).when(
                data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: UColors.blue400,
                          ),
                          SizedBox(width: USpace.space8),
                          Text(
                            "Complaint Details",
                            style: TextStyle(
                              color: UColors.blue400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PreviewListTile(
                              title: data.title,
                              subtitle: 'Title',
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Chip(
                            label: Text(
                              data.status.toUpperCase(),
                              style: const TextStyle(
                                color: UColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            side: BorderSide.none,
                            backgroundColor: data.status == 'open'
                                ? UColors.green400
                                : UColors.blue400,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text("Error"),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
