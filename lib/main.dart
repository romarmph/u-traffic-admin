import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/theme/data/dark_theme.dart';
import 'package:u_traffic_admin/config/theme/data/light_theme.dart';
import 'config/exports/exports.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: UTrafficAdmin(),
    ),
  );
}

class UTrafficAdmin extends ConsumerWidget {
  const UTrafficAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "U-Traffic Admin",
      themeMode: themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
      onGenerateInitialRoutes: (initialRoute) {
        return [
          MaterialPageRoute(
            builder: (context) => const Wrapper(),
          ),
        ];
      },
      onGenerateRoute: (settings) {
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
          case Routes.enforcers:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const EnforcerPage(),
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
      },
    );
  }
}
