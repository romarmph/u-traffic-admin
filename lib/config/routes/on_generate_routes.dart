import 'package:u_traffic_admin/config/exports/exports.dart';
import 'package:flutter/material.dart';

PageRouteBuilder onGenerateRoute(settings) {
  switch (settings.name) {
    case Routes.home:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const Wrapper(),
      );
    case Routes.login:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginPage(),
      );
    case Routes.adminStaffs:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const AdminPage(),
      );
    case Routes.adminStaffsCreate:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CreateAdminForm(),
      );
    case Routes.enforcers:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EnforcerPage(),
      );
    case Routes.enforcersCreate:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const CreateEnforcerForm(),
      );
    case Routes.enforcerSchedules:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const EnforcerSchedulePage(),
      );
    case Routes.tickets:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const TicketPage(),
      );
    case Routes.analytics:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const AnalyticsPage(),
      );
    case Routes.complaints:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const ComplaintsPage(),
      );
    case Routes.system:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SystemPage(),
      );
    case Routes.systemViolations:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SystemPage(),
      );
    case Routes.systemVehicleTypes:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SystemVehicleTypePage(),
      );
    case Routes.systemTrafficPosts:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SystemTrafficPostPage(),
      );
    case Routes.systemEnforcerSchedule:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SystemEnforcerSchedulePage(),
      );
    case Routes.settings:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const SettingsPage(),
      );
    case Routes.payment:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const PaymentHomePage(),
      );
    default:
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const Wrapper(),
      );
  }
}
