import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcersViewPage extends ConsumerWidget {
  const EnforcersViewPage({
    super.key,
    required this.enforcerId,
  });

  final String enforcerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageContainer(
      appBar: AppBar(
        title: const Text('Create Enforcer'),
        actions: const [CurrenAdminButton()],
      ),
      route: Routes.enforcersView,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: constraints.maxHeight - 100 - 48,
                    padding: const EdgeInsets.all(USpace.space16),
                    decoration: BoxDecoration(
                      color: UColors.white,
                      borderRadius: BorderRadius.circular(USpace.space16),
                    ),
                    child: ref.watch(getEnforcerById(enforcerId)).when(
                      data: (enforcer) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Enforcer Information',
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
                                        child: CachedNetworkImage(
                                          imageUrl: enforcer.photoUrl,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return const Center(
                                              child: Icon(
                                                Icons.error_outline_rounded,
                                                color: UColors.gray400,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: USpace.space16),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: enforcer.firstName,
                                              subtitle: 'First Name',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: enforcer.middleName,
                                              subtitle: 'Middle Name',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: enforcer.lastName,
                                              subtitle: 'Last Name',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 1,
                                            child: PreviewListTile(
                                              title: enforcer.suffix,
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
                                              title: enforcer.employeeNumber,
                                              subtitle: 'Employee Number',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: PreviewListTile(
                                              title: enforcer.email,
                                              subtitle: 'Email',
                                            ),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 3,
                                            child: Container(),
                                          ),
                                          const SizedBox(width: USpace.space12),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            EnforcerAuthorWidget(
                              createdBy: enforcer.createdBy,
                              updatedBy: enforcer.updatedBy,
                              createdAt: enforcer.createdAt,
                              updatedAt: enforcer.updatedAt,
                            ),
                          ],
                        );
                      },
                      error: (error, stackTrace) {
                        return Center(
                          child: Text(
                            error.toString(),
                            style: const TextStyle(
                              color: UColors.gray400,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
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
                            Navigator.of(navigatorKey.currentContext!).pop();
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
                          label: const Text('Update'),
                          icon: const Icon(Icons.edit_rounded),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class EnforcerAuthorWidget extends ConsumerWidget {
  const EnforcerAuthorWidget({
    super.key,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    this.updatedAt,
  });

  final String createdBy;
  final String updatedBy;
  final Timestamp createdAt;
  final Timestamp? updatedAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: UColors.gray50,
        borderRadius: BorderRadius.circular(
          USpace.space16,
        ),
        border: Border.all(
          color: UColors.gray200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          ref.watch(getAdminById(createdBy)).when(
            data: (admin) {
              final name =
                  '${admin.firstName} ${admin.middleName} ${admin.lastName}';
              return Row(
                children: [
                  Expanded(
                    child: PreviewListTile(
                      title: name,
                      subtitle: 'Created By',
                    ),
                  ),
                  Expanded(
                    child: PreviewListTile(
                      title: createdAt.toAmericanDate,
                      subtitle: 'Date Created',
                    ),
                  )
                ],
              );
            },
            error: (error, stackTrace) {
              return const SizedBox();
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          updatedBy.isEmpty
              ? const SizedBox()
              : ref.watch(getAdminById(updatedBy)).when(
                  data: (admin) {
                    final name =
                        '${admin.firstName} ${admin.middleName} ${admin.lastName}';
                    return Row(
                      children: [
                        Expanded(
                          child: PreviewListTile(
                            title: name,
                            subtitle: 'Updated By',
                          ),
                        ),
                        Expanded(
                          child: PreviewListTile(
                            title: updatedAt!.toAmericanDate,
                            subtitle: 'Date Updated',
                          ),
                        )
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    return const SizedBox();
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
