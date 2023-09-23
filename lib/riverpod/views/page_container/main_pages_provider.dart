import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

final mainPagesProvider = Provider<Widget>((ref) {
  final currentRoute = ref.watch(selectedRouteProvider);
  const Map<String, Widget> pages = {
    Routes.home: HomePage(),
    Routes.analytics: AnalyticsPage(),
    Routes.tickets: TicketPage(),
    Routes.enforcers: EnforcerPage(),
    Routes.adminStaffs: AdminPage(),
    Routes.system: SystemPage(),
    Routes.settings: SettingsPage(),
    Routes.complaints: ComplaintsPage(),
  };

  return pages[currentRoute]!;
});

final sideMenuControllerProvider = Provider<SideMenuController>((ref) {
  return SideMenuController();
});
