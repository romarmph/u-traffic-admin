import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:u_traffic_admin/views/admin/widgets/permission_view_widget.dart';

class AdminDetailsPage extends ConsumerWidget {
  const AdminDetailsPage({
    super.key,
    required this.adminId,
  });

  final String adminId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      appBar: AppBar(
        title: const Text('Create Admin'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.adminStaffsCreate,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: ref.watch(getAdminById(adminId)).when(
                data: (admin) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: constraints.maxHeight - 100 - 48,
                        padding: const EdgeInsets.all(USpace.space16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Admin Information',
                              style: TextStyle(
                                color: UColors.gray400,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(
                              height: USpace.space16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 256,
                                        height: 256,
                                        padding:
                                            const EdgeInsets.all(USpace.space4),
                                        decoration: BoxDecoration(
                                          color: UColors.gray100,
                                          borderRadius: BorderRadius.circular(
                                              USpace.space16),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          clipBehavior: Clip.antiAlias,
                                          child: CachedNetworkImage(
                                            imageUrl: admin.photoUrl,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: USpace.space16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: admin.firstName,
                                              subtitle: 'First Name',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: admin.middleName,
                                              subtitle: 'Middle Name',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: admin.lastName,
                                              subtitle: 'Last Name',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 2,
                                            child: PreviewListTile(
                                              title: admin.suffix,
                                              subtitle: 'Suffix',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: USpace.space12),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: admin.employeeNo,
                                              subtitle: 'Employee Number',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: admin.email,
                                              subtitle: 'Email',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: admin.status.name
                                                  .toUpperCase(),
                                              subtitle: 'Status',
                                              titleStyle: TextStyle(
                                                color: _statusColor(
                                                  admin.status,
                                                ),
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 2,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: USpace.space12),
                                      const Text(
                                        'Permissions',
                                        style: TextStyle(
                                          color: UColors.gray400,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      PermissionViewWidget(
                                        permissions: admin.permissions,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: USpace.space16,
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.all(USpace.space16),
                        decoration: BoxDecoration(
                          color: UColors.white,
                          borderRadius: BorderRadius.circular(USpace.space16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: USpace.space32,
                                  vertical: USpace.space24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                ref
                                    .watch(profilePhotoStateProvider.notifier)
                                    .state = null;
                                Navigator.of(navigatorKey.currentContext!)
                                    .pushReplacement(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) {
                                      return const AdminPage();
                                    },
                                  ),
                                );
                              },
                              child: const Text('Back'),
                            ),
                            const SizedBox(width: USpace.space16),
                            FilledButton.icon(
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: USpace.space32,
                                  vertical: USpace.space24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    USpace.space8,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              label: const Text('Update Admin'),
                              icon: const Icon(Icons.save_rounded),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      'Error: $error',
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
          );
        },
      ),
    );
  }

  Color _statusColor(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return UColors.blue500;
      case EmployeeStatus.offduty:
        return UColors.gray500;
      case EmployeeStatus.onduty:
        return UColors.green500;
      case EmployeeStatus.onleave:
        return UColors.yellow500;
      case EmployeeStatus.suspended:
        return UColors.red500;
      case EmployeeStatus.terminated:
        return UColors.red500;
      default:
        return UColors.gray400;
    }
  }
}
