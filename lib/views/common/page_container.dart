import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PageContainer extends ConsumerStatefulWidget {
  const PageContainer({
    super.key,
    this.appBar,
    required this.body,
    required this.route,
    this.endDrawer,
    this.scaffoldKey,
    this.floatingActionButton,
  });

  final Widget body;
  final AppBar? appBar;
  final String route;
  final Drawer? endDrawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? floatingActionButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PageContainerState();
}

class _PageContainerState extends ConsumerState<PageContainer> {
  @override
  Widget build(BuildContext context) {
    ref.watch(vehicleTypesProvider);
    ref.watch(violationsProvider);
    return AdminScaffold(
      backgroundColor: UColors.gray100,
      appBar: widget.appBar,
      endDrawer: widget.endDrawer,
      scaffoldKey: widget.scaffoldKey,
      floatingActionButton: widget.floatingActionButton,
      sideBar: SideBar(
        activeBackgroundColor: UColors.blue600,
        activeIconColor: UColors.white,
        activeTextStyle: const TextStyle(
          color: UColors.white,
          fontWeight: FontWeight.normal,
        ),
        textStyle: const TextStyle(
          color: UColors.gray500,
          fontWeight: FontWeight.normal,
        ),
        backgroundColor: UColors.white,
        selectedRoute: widget.route,
        onSelected: (item) {
          if (item.route == null || item.route == widget.route) return;

          Navigator.of(context).pushReplacementNamed(
            item.route!,
          );
        },
        // items: const [
        //   AdminMenuItem(
        //     title: "Dashboard",
        //     route: Routes.home,
        //     icon: Icons.dashboard_rounded,
        //   ),
        //   AdminMenuItem(
        //     title: "Payment",
        //     route: Routes.payment,
        //     icon: Icons.payment_rounded,
        //   ),
        //   AdminMenuItem(
        //     title: "Analytics",
        //     route: Routes.analytics,
        //     icon: Icons.analytics_rounded,
        //   ),
        //   AdminMenuItem(
        //     title: "Tickets",
        //     route: Routes.tickets,
        //     icon: Icons.article_rounded,
        //   ),
        //   AdminMenuItem(
        //     title: "Enforcers",
        //     route: Routes.enforcers,
        //     icon: Icons.security_rounded,
        //     children: [
        //       AdminMenuItem(
        //         title: 'View',
        //         route: Routes.enforcers,
        //         icon: Icons.view_list_rounded,
        //       ),
        //       AdminMenuItem(
        //         title: 'Create Enfocer',
        //         route: Routes.enforcersCreate,
        //         icon: Icons.person_add_rounded,
        //       ),
        //       AdminMenuItem(
        //         title: 'Schedule',
        //         route: Routes.enforcerSchedules,
        //         icon: Icons.calendar_month_rounded,
        //       ),
        //     ],
        //   ),
        //   AdminMenuItem(
        //     title: "Admin Staffs",
        //     route: Routes.adminStaffs,
        //     icon: Icons.admin_panel_settings_rounded,
        //     children: [
        //       AdminMenuItem(
        //         title: 'View',
        //         route: Routes.adminStaffs,
        //         icon: Icons.view_list_rounded,
        //       ),
        //       AdminMenuItem(
        //         title: 'Create',
        //         route: Routes.adminStaffsCreate,
        //         icon: Icons.person_add_rounded,
        //       ),
        //     ],
        //   ),
        //   AdminMenuItem(
        //     title: "Complaints",
        //     route: Routes.complaints,
        //     icon: Icons.report_rounded,
        //   ),
        //   AdminMenuItem(
        //     title: "System",
        //     route: Routes.system,
        //     icon: Icons.settings_applications_rounded,
        //     children: [
        //       AdminMenuItem(
        //         title: 'Violations',
        //         route: Routes.systemViolations,
        //         icon: Icons.line_style_rounded,
        //       ),
        //       AdminMenuItem(
        //         title: 'Vehicle Types',
        //         route: Routes.systemVehicleTypes,
        //         icon: Icons.car_rental_rounded,
        //       ),
        //       AdminMenuItem(
        //         title: 'Traffic Posts',
        //         route: Routes.systemTrafficPosts,
        //         icon: Icons.traffic_rounded,
        //       ),
        //     ],
        //   ),
        //   AdminMenuItem(
        //     title: "Settings",
        //     route: Routes.settings,
        //     icon: Icons.settings_rounded,
        //   ),
        // ],
        items: _getMenuByPermission(),
        header: Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            color: UColors.blue600,
            height: 100,
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/logo_white.png',
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "U-Traffic",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: widget.body,
    );
  }

  List<AdminMenuItem> _getMenuByPermission() {
    final currentAdmin = ref.watch(currentAdminProvider);
    final permissions = currentAdmin.permissions;

    final List<AdminMenuItem> menu = [];

    if (permissions.contains(AdminPermission.viewDashboard)) {
      menu.add(
        const AdminMenuItem(
          title: "Dashboard",
          route: Routes.home,
          icon: Icons.dashboard_rounded,
        ),
      );
    }

    if (permissions.contains(AdminPermission.managePayment)) {
      menu.add(
        const AdminMenuItem(
          title: "Payment",
          route: Routes.payment,
          icon: Icons.payment_rounded,
        ),
      );
    }

    if (permissions.contains(AdminPermission.viewAnalytics)) {
      menu.add(
        const AdminMenuItem(
          title: "Analytics",
          route: Routes.analytics,
          icon: Icons.analytics_rounded,
        ),
      );
    }

    if (permissions.contains(AdminPermission.manageTickets)) {
      menu.add(
        const AdminMenuItem(
          title: "Tickets",
          route: Routes.tickets,
          icon: Icons.article_rounded,
        ),
      );
    }

    if (permissions.contains(AdminPermission.manageEnforcer)) {
      menu.add(
        const AdminMenuItem(
          title: "Enforcers",
          route: Routes.enforcers,
          icon: Icons.security_rounded,
          children: [
            AdminMenuItem(
              title: 'View',
              route: Routes.enforcers,
              icon: Icons.view_list_rounded,
            ),
            AdminMenuItem(
              title: 'Create Enfocer',
              route: Routes.enforcersCreate,
              icon: Icons.person_add_rounded,
            ),
            AdminMenuItem(
              title: 'Schedule',
              route: Routes.enforcerSchedules,
              icon: Icons.calendar_month_rounded,
            ),
          ],
        ),
      );
    }

    if (permissions.contains(AdminPermission.manageAdmins)) {
      menu.add(
        const AdminMenuItem(
          title: "Admin Staffs",
          route: Routes.adminStaffs,
          icon: Icons.admin_panel_settings_rounded,
          children: [
            AdminMenuItem(
              title: 'View',
              route: Routes.adminStaffs,
              icon: Icons.view_list_rounded,
            ),
            AdminMenuItem(
              title: 'Create',
              route: Routes.adminStaffsCreate,
              icon: Icons.person_add_rounded,
            ),
          ],
        ),
      );
    }

    if (permissions.contains(AdminPermission.manageComplaints)) {
      menu.add(
        const AdminMenuItem(
          title: "Complaints",
          route: Routes.complaints,
          icon: Icons.report_rounded,
        ),
      );
    }

    if (permissions.contains(AdminPermission.manageSystem)) {
      menu.add(
        const AdminMenuItem(
          title: "System",
          route: Routes.system,
          icon: Icons.settings_applications_rounded,
          children: [
            AdminMenuItem(
              title: 'Violations',
              route: Routes.systemViolations,
              icon: Icons.line_style_rounded,
            ),
            AdminMenuItem(
              title: 'Vehicle Types',
              route: Routes.systemVehicleTypes,
              icon: Icons.car_rental_rounded,
            ),
            AdminMenuItem(
              title: 'Traffic Posts',
              route: Routes.systemTrafficPosts,
              icon: Icons.traffic_rounded,
            ),
          ],
        ),
      );
    }

    menu.add(
      const AdminMenuItem(
        title: "Settings",
        route: Routes.settings,
        icon: Icons.settings_rounded,
      ),
    );

    return menu;
  }
}
