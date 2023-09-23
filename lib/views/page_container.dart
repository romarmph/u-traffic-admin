import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class PageContainer extends ConsumerWidget {
  const PageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuController = ref.watch(sideMenuControllerProvider);

    final deviceWidth = MediaQuery.of(context).size.width;
    final isCompact = deviceWidth <= 600;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            SideMenu(
              alwaysShowFooter: true,
              style: SideMenuStyle(
                selectedColor: Colors.transparent,
              ),
              title: const SideMenuHeader(),
              controller: sideMenuController,
              items: [
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuDivider();
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Dashboard',
                      icon: Icons.dashboard_rounded,
                      route: Routes.home,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Analytics',
                      icon: Icons.analytics_rounded,
                      route: Routes.analytics,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Tickets',
                      icon: Icons.article_rounded,
                      route: Routes.tickets,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Enforcers',
                      icon: Icons.security_rounded,
                      route: Routes.enforcers,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Admin Staffs',
                      icon: Icons.people_rounded,
                      route: Routes.adminStaffs,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Complaints',
                      icon: Icons.report_rounded,
                      route: Routes.complaints,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'System',
                      icon: Icons.app_settings_alt_rounded,
                      route: Routes.system,
                    );
                  },
                ),
                SideMenuItem(
                  builder: (context, displayMode) {
                    return const SideMenuItemTile(
                      title: 'Settings',
                      icon: Icons.settings_rounded,
                      route: Routes.settings,
                    );
                  },
                ),
              ],
              footer: SideMenuFooter(isCompact: isCompact),
            ),
            Expanded(
              flex: 5,
              child: Navigator(
                onGenerateRoute: (settings) {
                  return PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      final page = ref.watch(mainPagesProvider);
                      print(page);
                      return page;
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
