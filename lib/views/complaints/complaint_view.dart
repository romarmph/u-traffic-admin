import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/riverpod/database/complains_database_providers.dart';
import 'package:u_traffic_admin/riverpod/database/driver_database_providers.dart';
import 'package:u_traffic_admin/views/complaints/reply_complaint_page.dart';
import 'package:u_traffic_admin/views/complaints/widgets/message_tile.dart';

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
                      Row(
                        children: [
                          const UBackButton(),
                          const SizedBox(width: USpace.space16),
                          const Icon(
                            Icons.info,
                            color: UColors.blue400,
                          ),
                          const SizedBox(width: USpace.space8),
                          const Text(
                            "Complaint Details",
                            style: TextStyle(
                              color: UColors.blue400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: USpace.space8),
                          data.closedBy.isEmpty
                              ? const SizedBox.shrink()
                              : ref
                                  .watch(getAdminByIdStream(data.closedBy))
                                  .when(
                                  data: (admin) {
                                    return SizedBox(
                                      width: 300,
                                      child: ListTile(
                                        title: Text(
                                          "Closed by ${admin.firstName} ${admin.lastName}",
                                          style: const UTextStyle()
                                              .textsmfontmedium,
                                        ),
                                        subtitle: Text(
                                          '${data.closedAt!.toAmericanDate} at ${data.closedAt!.toTime}',
                                          style: const UTextStyle()
                                              .textsmfontmedium,
                                        ),
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    return const SizedBox.shrink();
                                  },
                                  loading: () {
                                    return const SizedBox.shrink();
                                  },
                                ),
                          const SizedBox(width: USpace.space8),
                          data.reopenedBy.isEmpty
                              ? const SizedBox.shrink()
                              : ref
                                  .watch(getAdminByIdStream(data.reopenedBy))
                                  .when(
                                  data: (admin) {
                                    return SizedBox(
                                      width: 300,
                                      child: ListTile(
                                        title: Text(
                                          "Reopened by ${admin.firstName} ${admin.lastName}",
                                          style: const UTextStyle()
                                              .textsmfontmedium,
                                        ),
                                        subtitle: Text(
                                          '${data.reopenedAt!.toAmericanDate} at ${data.reopenedAt!.toTime}',
                                          style: const UTextStyle()
                                              .textsmfontmedium,
                                        ),
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) {
                                    return const SizedBox.shrink();
                                  },
                                  loading: () {
                                    return const SizedBox.shrink();
                                  },
                                ),
                          const Spacer(),
                          FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: data.status == "open"
                                    ? UColors.red400
                                    : UColors.green400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: USpace.space24,
                                  vertical: USpace.space16,
                                )),
                            onPressed: () async {
                              final result = await QuickAlert.show(
                                context: context,
                                type: QuickAlertType.confirm,
                                title: "Confirm to continue",
                                text: data.status == "open"
                                    ? "Are you sure to close this complaint?"
                                    : "Are you sure to reopen this complaint?",
                                onConfirmBtnTap: () {
                                  Navigator.of(context).pop(true);
                                },
                              );

                              if (result != true) {
                                return;
                              }

                              final currentAdmin =
                                  ref.watch(currentAdminProvider);
                              if (data.status == "open") {
                                await ComplaintsDatabase.instance
                                    .updateComplaint(
                                  data.copyWith(
                                    status: "close",
                                    closedAt: Timestamp.now(),
                                    closedBy: currentAdmin.id!,
                                  ),
                                );
                                ref.invalidate(
                                  getComplaintByIdProvider(complaint),
                                );
                              } else {
                                await ComplaintsDatabase.instance
                                    .updateComplaint(
                                  data.copyWith(
                                    status: "open",
                                    reopenedAt: Timestamp.now(),
                                    reopenedBy: currentAdmin.id!,
                                  ),
                                );
                                ref.invalidate(
                                  getComplaintByIdProvider(complaint),
                                );
                              }
                            },
                            child: Text(
                              data.status == "open"
                                  ? "Close Complaint"
                                  : "Reopen Complaint",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      // Start
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ref
                                  .watch(getDriverByIdProvider(data.sender))
                                  .when(
                                data: (driver) {
                                  return MessageTile(
                                    createdAt: data.createdAt,
                                    attachments: data.attachments,
                                    description: data.description,
                                    isFromDriver: data.isFromDriver,
                                    title: data.title,
                                    senderName:
                                        "${driver.firstName} ${driver.lastName}",
                                    senderPhotoUrl: driver.photoUrl,
                                    email: driver.email,
                                    phone: driver.phone,
                                  );
                                },
                                error: (error, stackTrace) {
                                  return const Center(
                                    child: Text("Error loading driver info"),
                                  );
                                },
                                loading: () {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                              ref.watch(getAllRepliesProvider(complaint)).when(
                                data: (data) {
                                  return Column(
                                    children: data.map((reply) {
                                      if (reply.isFromDriver) {
                                        return ref
                                            .watch(getDriverByIdProvider(
                                                reply.sender))
                                            .when(
                                          data: (driver) {
                                            return MessageTile(
                                              createdAt: reply.createdAt,
                                              attachments: reply.attachments,
                                              description: reply.description,
                                              isFromDriver: reply.isFromDriver,
                                              title: reply.title,
                                              senderName:
                                                  "${driver.firstName} ${driver.lastName}",
                                              senderPhotoUrl: driver.photoUrl,
                                              email: driver.email,
                                              phone: driver.phone,
                                            );
                                          },
                                          error: (error, stackTrace) {
                                            return const Center(
                                              child: Text(
                                                  "Error loading driver info"),
                                            );
                                          },
                                          loading: () {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                      }

                                      return ref
                                          .watch(
                                              getAdminByIdStream(reply.sender))
                                          .when(
                                        data: (admin) {
                                          return MessageTile(
                                            createdAt: reply.createdAt,
                                            attachments: reply.attachments,
                                            description: reply.description,
                                            isFromDriver: reply.isFromDriver,
                                            title: reply.title,
                                            senderName:
                                                "${admin.firstName} ${admin.lastName}",
                                            senderPhotoUrl: admin.photoUrl,
                                            email: admin.email,
                                          );
                                        },
                                        error: (error, stackTrace) {
                                          return const Center(
                                            child: Text(
                                                "Error loading driver info"),
                                          );
                                        },
                                        loading: () {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      );
                                    }).toList(),
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
                            ],
                          ),
                        ),
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
      floatingActionButton: ref.watch(getComplaintByIdProvider(complaint)).when(
        data: (complaint) {
          if (complaint.status == "close") return null;

          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ReplyComplaintPage(
                    title: complaint.title,
                    parentThread: complaint.parentThread ?? complaint.id!,
                  ),
                ),
              );
            },
            label: const Text('Reply'),
            icon: const Icon(Icons.reply),
          );
        },
        error: (error, stackTrace) {
          return null;
        },
        loading: () {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: UColors.white,
              borderRadius: BorderRadius.circular(USpace.space8),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
