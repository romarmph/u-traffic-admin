import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PermissionSelectionWidget extends ConsumerStatefulWidget {
  const PermissionSelectionWidget({
    super.key,
    this.oldPermissions,
    this.isUpdateMode = false,
  });

  final List<AdminPermission>? oldPermissions;
  final bool isUpdateMode;

  @override
  ConsumerState<PermissionSelectionWidget> createState() =>
      PermissionSelectionWidgetState();
}

class PermissionSelectionWidgetState
    extends ConsumerState<PermissionSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    List<AdminPermission> selected = ref.watch(selectedPermissionsProvider);
    if (widget.oldPermissions != null && selected.isEmpty) {
      widget.oldPermissions!.sort(
        (a, b) => a.name.compareTo(b.name),
      );
      selected = widget.oldPermissions!;
    }

    selected.sort(
      (a, b) => a.name.compareTo(b.name),
    );

    if (selected == widget.oldPermissions) {
      selected = widget.oldPermissions!;
    }

    return Container(
      padding: const EdgeInsets.all(USpace.space16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          USpace.space8,
        ),
        border: Border.all(
          color: UColors.gray200,
          width: 1,
        ),
      ),
      child: GridView.count(
        childAspectRatio: 8 / 2,
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        controller: ScrollController(
          keepScrollOffset: false,
        ),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.manageAdmins,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.manageAdmins,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.manageAdmins,
              ),
              title: const Text('Manage Admin'),
              subtitle: const Text(
                'Allow admin to manage other admins',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.manageAdmins
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.manageAdmins)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.manageEnforcer,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.manageEnforcer,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.manageEnforcer,
              ),
              title: const Text('Manage Enforcer'),
              subtitle: const Text(
                'Allow admin to manage enforcers',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.manageEnforcer
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.manageEnforcer)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.manageTickets,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.manageTickets,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.manageTickets,
              ),
              title: const Text('Manage Tickets'),
              subtitle: const Text(
                'Allow admin to manage tickets',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.manageTickets
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.manageTickets)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.managePayment,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.managePayment,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.managePayment,
              ),
              title: const Text('Manage Payment'),
              subtitle: const Text(
                'Allow admin to manage payments',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.managePayment
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.managePayment)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.manageComplaints,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.manageComplaints,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.manageComplaints,
              ),
              title: const Text('Manage Complaints'),
              subtitle: const Text(
                'Allow admin to manage complaints',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.manageComplaints
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where((element) =>
                        element != AdminPermission.manageComplaints)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.manageSystem,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.manageSystem,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.manageSystem,
              ),
              title: const Text('Manage System'),
              subtitle: const Text(
                'Allow admin to manage system settings',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.manageSystem
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.manageSystem)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.viewAnalytics,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.viewAnalytics,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.viewAnalytics,
              ),
              title: const Text('View Analytics'),
              subtitle: const Text(
                'Allow admin to view analytics',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.viewAnalytics
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.viewAnalytics)
                  ];
                }
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: selected.contains(
                AdminPermission.viewDashboard,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: selected.contains(
                  AdminPermission.viewDashboard,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: widget.isUpdateMode,
              value: selected.contains(
                AdminPermission.viewDashboard,
              ),
              title: const Text('View Dashboard'),
              subtitle: const Text(
                'Allow admin to view dashboard',
                style: TextStyle(
                  color: UColors.gray400,
                  fontSize: 12,
                ),
              ),
              onChanged: (value) {
                if (value!) {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected,
                    AdminPermission.viewDashboard
                  ];
                } else {
                  ref.read(selectedPermissionsProvider.notifier).state = [
                    ...selected.where(
                        (element) => element != AdminPermission.viewDashboard)
                  ];
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
