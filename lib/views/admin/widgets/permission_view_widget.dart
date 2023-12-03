import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PermissionViewWidget extends ConsumerWidget {
  const PermissionViewWidget({
    super.key,
    required this.permissions,
  });

  final List<AdminPermission> permissions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              color: permissions.contains(
                AdminPermission.manageAdmins,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.manageAdmins,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.manageEnforcer,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.manageEnforcer,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.manageTickets,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.manageTickets,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.managePayment,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.managePayment,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.manageComplaints,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.manageComplaints,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.manageSystem,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.manageSystem,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.viewAnalytics,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.viewAnalytics,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: permissions.contains(
                AdminPermission.viewDashboard,
              )
                  ? UColors.blue200
                  : UColors.gray50,
              borderRadius: BorderRadius.circular(
                USpace.space8,
              ),
              border: Border.all(
                color: permissions.contains(
                  AdminPermission.viewDashboard,
                )
                    ? UColors.blue400
                    : UColors.gray300,
                width: 1,
              ),
            ),
            child: CheckboxListTile(
              enabled: false,
              value: permissions.contains(
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
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
